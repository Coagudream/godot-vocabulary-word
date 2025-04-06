## 管理单词分段的UI界面。
## 允许设置每段的单词数量，并动态创建分段按钮，分配单词索引。
class_name Segmentation
extends PanelContainer

# 分段按钮创建完成并分配索引后发射的信号
signal segmentation_updated

# 预加载分段按钮场景
const ROUND_BUTTON = preload("res://UI/分段模式/round_button.tscn") # 如有问题可改用ASCII路径

# --- UI节点引用 ---
@onready var iexicon_label: Label = %Iexicon # 更清晰的命名（添加Label后缀）
@onready var words_label: Label = %Words   
@onready var total_amount_spinbox: SpinBox = %TotalAmount 
@onready var total_label: Label = %Total       
@onready var total_grid: GridContainer = %TotalGrid

# --- 分段属性 ---
# 每段的单词数量
var words_per_segment: int = 30:
	set(value):
		var new_value = max(1, value) # 确保至少1个单词/段
		if words_per_segment == new_value:
			return # 值未变化时避免重复更新
		words_per_segment = new_value
		# 节点就绪且值不同时更新UI控件
		if is_node_ready() and total_amount_spinbox.value != words_per_segment:
			total_amount_spinbox.value = words_per_segment
		# 延迟触发更新逻辑（避免初始化问题）
		call_deferred("_update_segmentation")

# 根据总单词数和words_per_segment计算的总段数
var total_segments: int = 0:
	set(value):
		if total_segments == value:
			return
		total_segments = value
		if not is_node_ready():
			return # 等待节点就绪再更新UI
		total_label.text = "共计 %s 段" % total_segments


# --- 状态变量 ---
# 从ArrayWords复制并打乱的单词索引数组，用于分配
var _shuffled_indices: Array[int] = []
# 当前在_shuffled_indices中的切片起始位置
var _current_index_offset: int = 0


# 节点首次加入场景树时调用
func _ready() -> void:
	# 等待必要数据加载（假设Events是单例）
	if Events and Events.has_signal("json_load_completed"):
		# 仅在ArrayWords可能未就绪时等待
		if ArrayWords.get_len_words_array() == 0:
			await Events.json_load_completed
	else:
		push_warning("未找到Events单例或json_load_completed信号。")

	# 连接信号
	total_amount_spinbox.value_changed.connect(_on_total_amount_value_changed)
	segmentation_updated.connect(_assign_indices_to_buttons)

	# 通过setter逻辑初始化（延迟执行）
	words_per_segment = int(total_amount_spinbox.min_value if total_amount_spinbox.value < total_amount_spinbox.min_value else total_amount_spinbox.value)
	total_amount_spinbox.value = words_per_segment # 确保SpinBox显示正确初始值

	# 首次更新
	call_deferred("_update_segmentation")


# --- 信号处理 ---

# SpinBox值变化时调用
func _on_total_amount_value_changed(value: float) -> void:
	self.words_per_segment = int(value) # 使用setter处理逻辑


# --- 核心逻辑方法 ---

# 重新计算分段、更新UI标签并重建按钮
func _update_segmentation() -> void:
	if not is_node_ready():
		await ready # 理论上不会发生，安全检查

	var total_word_count: int = ArrayWords.get_len_words_array()

	# 更新基础信息标签
	iexicon_label.text = "当前词库: " + ArrayWords.get_iexicon()
	words_label.text = "共计 %s 单词" % total_word_count

	# 防止除以零
	if words_per_segment <= 0:
		push_error("每段单词数必须为正数。")
		self.total_segments = 0 # 使用setter更新标签
		_clear_buttons()
		return

	# 计算总段数（向上取整除法）
	if total_word_count == 0:
		self.total_segments = 0
	else:
		# 整数向上取整公式: (a + b - 1) / b
		self.total_segments = (total_word_count + words_per_segment - 1) / words_per_segment

	# 重建分段按钮
	_recreate_segment_buttons() # 信号连接会处理索引分配


# 清除网格中的现有按钮
func _clear_buttons() -> void:
	for child in total_grid.get_children():
		child.queue_free()


# 根据当前total_segments创建新按钮
func _recreate_segment_buttons() -> void:
	_clear_buttons()

	if total_segments <= 0:
		_reset_shuffled_indices() # 即使无按钮也重置状态
		emit_signal("segmentation_updated") # 标记完成
		return

	# 在创建按钮前准备打乱的索引
	_reset_shuffled_indices()

	# 在主线程创建按钮（通常足够快）
	for i in range(1, total_segments + 1):
		var button_instance = ROUND_BUTTON.instantiate()
		if not button_instance is TotalButton: # 类型检查
			push_error("实例化的节点不是TotalButton类型。")
			button_instance.queue_free()
			continue

		button_instance.text = "%s" % i
		total_grid.add_child(button_instance)

	# 所有按钮添加完成后发射信号（延迟确保节点入树）
	call_deferred("emit_signal", "segmentation_updated")


# 重置并打乱本地单词索引副本
func _reset_shuffled_indices() -> void:
	_shuffled_indices = ArrayWords.all_index_array.duplicate() # 获取新副本
	_shuffled_indices.shuffle()
	_current_index_offset = 0 # 重置切片偏移量


# 为每个分段按钮分配计算好的单词索引
func _assign_indices_to_buttons() -> void:
	if not is_instance_valid(total_grid):
		return # 网格可能已释放

	var buttons = total_grid.get_children()
	if buttons.size() != total_segments:
		push_warning("按钮数量不匹配。预期 %d，实际 %d。" % [total_segments, buttons.size()])

	_current_index_offset = 0 # 确保从打乱列表的头部开始

	for i in range(buttons.size()):
		var button: TotalButton = buttons[i] as TotalButton # 安全类型转换
		if not button:
			push_error("total_grid的子节点%d不是TotalButton。" % i)
			continue

		# 计算切片边界
		var start_index = _current_index_offset
		var end_index = min(start_index + words_per_segment, _shuffled_indices.size())

		# 获取该按钮的索引切片
		if start_index < _shuffled_indices.size():
			button.array_index = _shuffled_indices.slice(start_index, end_index - 1) # slice的end是包含的
		else:
			button.array_index = [] # 无剩余索引

		# 更新下一个按钮的偏移量
		_current_index_offset = end_index
