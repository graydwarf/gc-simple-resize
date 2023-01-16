extends ColorRect

var _grabHandle = ""
var _isDraggingNode = false
var _localMousePosition = Vector2(0,0)
var _originalWidth = 0
var _originalPositionX = 0
var	_originalHeight = 0
var _originalPositionY = 0

func _physics_process(_delta):
	if _grabHandle == "" && _isDraggingNode:
		var globalMousePosition = get_global_mouse_position()
		rect_global_position = globalMousePosition - _localMousePosition
	elif _grabHandle == "right":
		rect_size.x = get_global_mouse_position().x - rect_global_position.x
		if rect_size.x < 2:
			_grabHandle = "left"
			_originalWidth = 1
			_originalPositionX = rect_global_position.x
			return
	elif _grabHandle == "left":
		rect_global_position.x = get_global_mouse_position().x
		if rect_global_position.x > (_originalPositionX + _originalWidth):
			# Prevent the rect from moving as we transition
			rect_global_position.x = _originalPositionX + _originalWidth - 1
			_grabHandle = "right"
			return
		var deltaWidth = _originalPositionX - rect_global_position.x
		rect_size.x = _originalWidth + deltaWidth
	elif _grabHandle == "top":
		rect_global_position.y = get_global_mouse_position().y
		if rect_global_position.y > (_originalPositionY + _originalHeight):
			# Prevent the rect from moving as we transition
			rect_global_position.y = _originalPositionY + _originalHeight - 1
			_grabHandle = "bottom"
			return
		var deltaHeight = _originalPositionY - rect_global_position.y
		rect_size.y = _originalHeight + deltaHeight
	elif _grabHandle == "bottom":
		rect_size.y = get_global_mouse_position().y - rect_global_position.y
		if rect_size.y < 2:
			_grabHandle = "top"
			_originalHeight = 1
			_originalPositionY = rect_global_position.y
			return
	elif _grabHandle == "bottom-right":
		rect_size = get_global_mouse_position() - rect_global_position

func _on_ResizableNode_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		_localMousePosition = get_local_mouse_position()
		_isDraggingNode = true
	elif event is InputEventMouseButton and event.button_index == BUTTON_LEFT and !event.is_pressed():
		_isDraggingNode = false
		
func _on_RightGrabHandle_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		_grabHandle = "right"
	elif event is InputEventMouseButton and event.button_index == BUTTON_LEFT and !event.is_pressed():
		_grabHandle = ""

func _on_LeftGrabHandle_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		_originalWidth = rect_size.x
		_originalPositionX = rect_global_position.x
		_grabHandle = "left"
	elif event is InputEventMouseButton and event.button_index == BUTTON_LEFT and !event.is_pressed():
		_grabHandle = ""

func _on_TopGrabHandle_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		_originalHeight = rect_size.y
		_originalPositionY = rect_global_position.y
		_grabHandle = "top"
	elif event is InputEventMouseButton and event.button_index == BUTTON_LEFT and !event.is_pressed():
		_grabHandle = ""

func _on_BottomGrabHandle_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		_grabHandle = "bottom"
	elif event is InputEventMouseButton and event.button_index == BUTTON_LEFT and !event.is_pressed():
		_grabHandle = ""

func _on_CornerGrabHandle_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		_grabHandle = "bottom-right"
	elif event is InputEventMouseButton and event.button_index == BUTTON_LEFT and !event.is_pressed():
		_grabHandle = ""
