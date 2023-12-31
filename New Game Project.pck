GDPC                                                                                           X   res://.godot/exported/133200997/export-021e70dc9a0e55530b40268847043520-character.scn   �)            �B�y�$	�in��˻    T   res://.godot/exported/133200997/export-36a25e342948d0ceacc500772b5412b3-player.scn   X      {      as;�����Z�,3��    X   res://.godot/exported/133200997/export-45fcf9618186e808d2822186ae3763f1-test_world.scn  �q      �      �A�$ڴY$o���~�|    X   res://.godot/exported/133200997/export-b5aaf044b72cc3159bdaffa87440fe40-reticle_1.scn   �      i      ���NY����m�7     T   res://.godot/exported/133200997/export-d85448a68f01bbd6644b4b40ef87233e-level.scn   �^      "      N��~U͕�c�҉�17    X   res://.godot/exported/133200997/export-fc30c6f2d988778d581100b68ad6a198-reticle_0.scn           �      }̇��Ya�q�w9�    ,   res://.godot/global_script_class_cache.cfg  �             ��Р�8���8~$}P�    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex�F      �      �̛�*$q�*�́        res://.godot/uid_cache.bin  Д            �}��)�~�hJ�ll�       res://MeshInstance3D.gd �p      �       JKp�)�,S_��ŵ�X       res://Player.gd @T      �      c��H��5�][2b�J�        res://addons/fpc/character.gd          �      �u�`��=r#]��O�    (   res://addons/fpc/character.tscn.remap   0�      f       ���k��v|�cɧ�Ϗ       res://addons/fpc/debug.gd   �D      �      $O=\L�Ys�|�rgF�    0   res://addons/fpc/reticles/reticle_0.tscn.remap  P�      f       �ƫD5�)����M    0   res://addons/fpc/reticles/reticle_1.tscn.remap  ��      f       ��b�Wlm!ɠ�Djk�{       res://icon.svg  �      �      C��=U���^Qu��U3       res://icon.svg.import   �S      �       b�P5
��G�n,(�       res://level.gdshader�o            ԋ�!n�#��%i��       res://level.tscn.remap  �      b       �6�-j�p�	��)��       res://player.tscn.remap ��      c       ������T�?�L���       res://project.binary��      �      ��L���t�E_x�Ɇ       res://test_world.tscn.remap ��      g       �#�a!e�9=�+3\��            RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    script/source 	   _bundled    script           local://GDScript_10f85          local://PackedScene_7t83o        	   GDScript          �  extends CenterContainer


@export_category("Reticle")
@export_group("Nodes")
@export var character : CharacterBody3D

@export_group("Settings")
@export var dot_size : int = 1
@export var dot_color : Color = Color.WHITE


func _process(_delta):
	if visible: # If the reticle is disabled (not visible), don't bother updating it
		update_reticle_settings()

func update_reticle_settings():
	$dot.scale.x = dot_size
	$dot.scale.y = dot_size
	$dot.color = dot_color
    PackedScene          	         names "         Reticle    anchor_left    anchor_top    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    CenterContainer    dot    polygon 
   Polygon2D    	   variants             ?                %        ��  ��  �?  ��  �?  �?  ��  �?      node_count             nodes        ��������       ����                                                                	   ����   
                conn_count              conns               node_paths              editable_instances              version             RSRC            RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    script/source 	   _bundled    script           local://GDScript_a8kpl          local://PackedScene_8nm3s �
      	   GDScript          U	  extends CenterContainer


@export_category("Reticle")
@export_group("Nodes")
@export var reticle_lines : Array[Line2D]
@export var character : CharacterBody3D

@export_group("Animate")
@export var animated_reticle : bool = true
@export var reticle_speed : float = 0.5
@export var reticle_spread : float = 4.0

@export_group("Dot Settings")
@export var dot_size : int = 1
@export var dot_color : Color = Color.WHITE

@export_group("Line Settings")
@export var line_color : Color = Color.WHITE
@export var line_width : int = 2
@export var line_length : int = 10
@export var line_distance : int = 5
@export_enum("None", "Round") var cap_mode : int = 0


func _process(_delta):
	if visible: # If the reticle is disabled (not visible), don't bother updating it
		update_reticle_settings()
		if animated_reticle:
			animate_reticle_lines()


func animate_reticle_lines():
	var vel = character.get_real_velocity()
	var origin = Vector3(0,0,0)
	var pos = Vector2(0,0)
	var speed = origin.distance_to(vel)
	
	reticle_lines[0].position = lerp(reticle_lines[0].position, pos + Vector2(0, -speed * reticle_spread), reticle_speed)
	reticle_lines[1].position = lerp(reticle_lines[1].position, pos + Vector2(-speed * reticle_spread, 0), reticle_speed)
	reticle_lines[2].position = lerp(reticle_lines[2].position, pos + Vector2(speed * reticle_spread, 0), reticle_speed)
	reticle_lines[3].position = lerp(reticle_lines[3].position, pos + Vector2(0, speed * reticle_spread), reticle_speed)


func update_reticle_settings():
	# Dot
	$dot.scale.x = dot_size
	$dot.scale.y = dot_size
	$dot.color = dot_color
	
	# Lines
	for line in reticle_lines:
		line.default_color = line_color
		line.width = line_width
		if cap_mode == 0:
			line.begin_cap_mode = Line2D.LINE_CAP_NONE
			line.end_cap_mode = Line2D.LINE_CAP_NONE
		elif cap_mode == 1:
			line.begin_cap_mode = Line2D.LINE_CAP_ROUND
			line.end_cap_mode = Line2D.LINE_CAP_ROUND
	
	# Please someone find a better way to do this
	reticle_lines[0].points[0].y = -line_distance
	reticle_lines[0].points[1].y = -line_length - line_distance
	reticle_lines[1].points[0].x = -line_distance
	reticle_lines[1].points[1].x = -line_length - line_distance
	reticle_lines[2].points[0].x = line_distance
	reticle_lines[2].points[1].x = line_length + line_distance
	reticle_lines[3].points[0].y = line_distance
	reticle_lines[3].points[1].y = line_length + line_distance
    PackedScene          	         names "         Reticle    anchor_left    anchor_top    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    script    CenterContainer    dot    polygon 
   Polygon2D    top    points    width    Line2D    left    right    bottom    	   variants    	         ?                %        ��  ��  �?  ��  �?  �?  ��  �?%            ��      p�      @%        ��      p�    %        �@      pA    %            �@      pA      node_count             nodes     J   ��������       ����                                                                	   ����   
                        ����                                 ����                                 ����                                 ����                         conn_count              conns               node_paths              editable_instances              version             RSRC       extends CharacterBody3D

# TODO: Add descriptions for each value

@export_category("Character")
@export var base_speed : float = 3.0
@export var sprint_speed : float = 6.0
@export var crouch_speed : float = 1.0

@export var acceleration : float = 10.0
@export var jump_velocity : float = 4.5
@export var mouse_sensitivity : float = 0.1

@export_group("Nodes")
@export var HEAD : Node3D
@export var CAMERA : Camera3D
@export var CAMERA_ANIMATION : AnimationPlayer

@export_group("Controls")
# We are using UI controls because they are built into Godot Engine so they can be used right away
@export var JUMP : String = "ui_accept"
@export var LEFT : String = "ui_left"
@export var RIGHT : String = "ui_right"
@export var FORWARD : String = "ui_up"
@export var BACKWARD : String = "ui_down"
@export var PAUSE : String = "ui_cancel"
@export var CROUCH : String
@export var SPRINT : String

@export_group("Feature Settings")
@export var immobile : bool = false
@export var jumping_enabled : bool = true
@export var in_air_momentum : bool = true
@export var motion_smoothing : bool = true
@export var sprint_enabled : bool = true
@export var crouch_enabled : bool = true
@export_enum("Hold to Crouch", "Toggle Crouch") var crouch_mode : int = 0
@export_enum("Hold to Sprint", "Toggle Sprint") var sprint_mode : int = 0
@export var dynamic_fov : bool = true
@export var continuous_jumping : bool = true
@export var view_bobbing : bool = true

# Member variables
var speed : float = base_speed
var is_crouching : bool = false
var is_sprinting : bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes
var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity") # Don't set this as a const, see the gravity section in _physics_process


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	
	# Add some debug data
	$UserInterface/DebugPanel.add_property("Movement Speed", speed, 1)
	$UserInterface/DebugPanel.add_property("Velocity", get_real_velocity(), 2)
	
	# Gravity
	#gravity = ProjectSettings.get_setting("physics/3d/default_gravity") # If the gravity changes during your game, uncomment this code
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	handle_jumping()
	
	var input_dir = Vector2.ZERO
	if !immobile:
		input_dir = Input.get_vector(LEFT, RIGHT, FORWARD, BACKWARD)
	
	handle_movement(delta, input_dir)
	
	toggle_crouch()
	toggle_sprint(input_dir)
	
	if is_crouching:
		speed = crouch_speed
	elif is_sprinting:
		speed = sprint_speed
	else:
		speed = base_speed
	
	
	if view_bobbing:
		headbob_animation(input_dir)


func handle_jumping():
	if jumping_enabled:
		if continuous_jumping:
			if Input.is_action_pressed(JUMP) and is_on_floor():
				velocity.y += jump_velocity
		else:
			if Input.is_action_just_pressed(JUMP) and is_on_floor():
				velocity.y += jump_velocity

func handle_movement(delta, input_dir):
	
	var direction = input_dir.rotated(-HEAD.rotation.y)
	direction = Vector3(direction.x, 0, direction.y)
	
	move_and_slide()
	
	if in_air_momentum:
		if is_on_floor(): # Don't lerp y movement
			if motion_smoothing:
				velocity.x = lerp(velocity.x, direction.x * speed, acceleration * delta)
				velocity.z = lerp(velocity.z, direction.z * speed, acceleration * delta)
			else:
				velocity.x = direction.x * speed
				velocity.z = direction.z * speed
	else:
		if motion_smoothing:
			velocity.x = lerp(velocity.x, direction.x * speed, acceleration * delta)
			velocity.z = lerp(velocity.z, direction.z * speed, acceleration * delta)
		else:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed


func _process(delta):
	
	$UserInterface/DebugPanel.add_property("FPS", 1.0/delta, 0)
	
	if Input.is_action_just_pressed(PAUSE):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		elif Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		HEAD.rotation_degrees.y -= event.relative.x * mouse_sensitivity
		HEAD.rotation_degrees.x -= event.relative.y * mouse_sensitivity
		HEAD.rotation.x = clamp(HEAD.rotation.x, deg_to_rad(-90), deg_to_rad(90))


func toggle_crouch():
	if crouch_enabled:
		if crouch_mode == 0:
			is_crouching = Input.is_action_pressed(CROUCH)
		elif crouch_mode == 1:
			if Input.is_action_just_pressed(CROUCH):
				is_crouching = !is_crouching
	
		# Replace with your own crouch animation code
		if is_crouching:
			$Collision.scale.y = lerp($Collision.scale.y, 0.75, 0.2)
		else:
			$Collision.scale.y = lerp($Collision.scale.y, 1.0, 0.2)


func toggle_sprint(moving):
	if sprint_enabled:
		if sprint_mode == 0:
			if !is_crouching: # Crouching takes priority over sprinting
				is_sprinting = Input.is_action_pressed(SPRINT)
			else:
				is_sprinting = false # Fix a bug where if you are sprinting and then crouch then let go of the sprinting button you keep sprinting
		elif sprint_mode == 1:
			if Input.is_action_just_pressed(SPRINT):
				if !is_crouching:
					is_sprinting = !is_sprinting
				else:
					is_sprinting = false
	
		if dynamic_fov:
			if is_sprinting and moving:
				CAMERA.fov = lerp(CAMERA.fov, 85.0, 0.3)
			else:
				CAMERA.fov = lerp(CAMERA.fov, 75.0, 0.3)


func headbob_animation(moving):
	if moving and is_on_floor():
		CAMERA_ANIMATION.play("headbob")
		CAMERA_ANIMATION.speed_scale = speed / base_speed
	else:
		CAMERA_ANIMATION.play("RESET")
         RSRC                    PackedScene            ��������                                            �      Head    Camera    camera_animation 	   position    top    left    right    bottom    ..    UserInterface 
   Reticle_1    resource_local_to_scene    resource_name    render_priority 
   next_pass    transparency    blend_mode 
   cull_mode    depth_draw_mode    no_depth_test    shading_mode    diffuse_mode    specular_mode    disable_ambient_light    disable_fog    vertex_color_use_as_albedo    vertex_color_is_srgb    albedo_color    albedo_texture    albedo_texture_force_srgb    albedo_texture_msdf 	   metallic    metallic_specular    metallic_texture    metallic_texture_channel 
   roughness    roughness_texture    roughness_texture_channel    emission_enabled 	   emission    emission_energy_multiplier    emission_operator    emission_on_uv2    emission_texture    normal_enabled    normal_scale    normal_texture    rim_enabled    rim 	   rim_tint    rim_texture    clearcoat_enabled 
   clearcoat    clearcoat_roughness    clearcoat_texture    anisotropy_enabled    anisotropy    anisotropy_flowmap    ao_enabled    ao_light_affect    ao_texture 
   ao_on_uv2    ao_texture_channel    heightmap_enabled    heightmap_scale    heightmap_deep_parallax    heightmap_flip_tangent    heightmap_flip_binormal    heightmap_texture    heightmap_flip_texture    subsurf_scatter_enabled    subsurf_scatter_strength    subsurf_scatter_skin_mode    subsurf_scatter_texture &   subsurf_scatter_transmittance_enabled $   subsurf_scatter_transmittance_color &   subsurf_scatter_transmittance_texture $   subsurf_scatter_transmittance_depth $   subsurf_scatter_transmittance_boost    backlight_enabled 
   backlight    backlight_texture    refraction_enabled    refraction_scale    refraction_texture    refraction_texture_channel    detail_enabled    detail_mask    detail_blend_mode    detail_uv_layer    detail_albedo    detail_normal 
   uv1_scale    uv1_offset    uv1_triplanar    uv1_triplanar_sharpness    uv1_world_triplanar 
   uv2_scale    uv2_offset    uv2_triplanar    uv2_triplanar_sharpness    uv2_world_triplanar    texture_filter    texture_repeat    disable_receive_shadows    shadow_to_opacity    billboard_mode    billboard_keep_scale    grow    grow_amount    fixed_size    use_point_size    point_size    use_particle_trails    proximity_fade_enabled    proximity_fade_distance    msdf_pixel_range    msdf_outline_size    distance_fade_mode    distance_fade_min_distance    distance_fade_max_distance    script    lightmap_size_hint 	   material    custom_aabb    flip_faces    add_uv2    uv2_padding    radius    height    radial_segments    rings    custom_solver_bias    margin    length 
   loop_mode    step    tracks/0/type    tracks/0/imported    tracks/0/enabled    tracks/0/path    tracks/0/interp    tracks/0/loop_wrap    tracks/0/keys    _data    default_base_scale    default_font    default_font_size (   MarginContainer/constants/margin_bottom &   MarginContainer/constants/margin_left '   MarginContainer/constants/margin_right %   MarginContainer/constants/margin_top 	   _bundled       Script    res://addons/fpc/character.gd ��������   PackedScene )   res://addons/fpc/reticles/reticle_1.tscn (D�N��   Script    res://addons/fpc/debug.gd ��������   !   local://StandardMaterial3D_kp17n �         local://CapsuleMesh_jw1de �         local://CapsuleShape3D_uy03j          local://Animation_gh776 <         local://Animation_lrqmv Z         local://AnimationLibrary_o0unb �         local://Theme_wdf0f 1         local://PackedScene_mpr75 w         StandardMaterial3D          ��h?��?      �?3         5      ��L>y         CapsuleMesh    {             y         CapsuleShape3D    y      
   Animation             RESET �      o�:�         �         value �          �         �              �         �         �               times !                transitions !        �?      values                            update        y      
   Animation 
            headbob �         �         value �          �         �              �         �         �               times !            �>   ?  @?  �?      transitions !        �?  �?  �?  �?  �?      values                         ��L���L�                      ��L=��L�                         update        y         AnimationLibrary    �               RESET                headbob          y         Theme    �      
   �      
   �      
   �      
   y         PackedScene    �      	         names "   2   
   Character    script    HEAD    CAMERA    CAMERA_ANIMATION    CROUCH    SPRINT    CharacterBody3D    Mesh 
   transform    mesh    MeshInstance3D 
   Collision    shape    CollisionShape3D    Head    Node3D    Camera 	   Camera3D    camera_animation 
   libraries    blend_times    AnimationPlayer    UserInterface    layout_mode    anchors_preset    anchor_right    anchor_bottom    grow_horizontal    grow_vertical    mouse_filter    Control 
   Reticle_1    reticle_lines 
   character    dot    top    left    right    bottom    DebugPanel    visible    offset_left    offset_top    offset_right    offset_bottom    theme    PanelContainer    MarginContainer    VBoxContainer    	   variants                                                           crouch       sprint      �?              �?              �?      �?                           �?              �?              �?      �?       ��?z,�:0 �    ��?; =; =0 ��?                                     	   ,      headbob ,      RESET       ?,      RESET ,      headbob       ?,      RESET ,      RESET       ?                 �?                                                                                               A    ��C     HB                        node_count             nodes     �   ��������       ����            @     @     @                                 ����   	      
                        ����   	                              ����   	   	                    ����   	   
                    ����                                 ����                                                        ���                !  @   "  @              /   (   ����   )            *      +      ,      -      .                       0   0   ����             	       1   1   ����                   conn_count              conns               node_paths              editable_instances             	   
         version       y      RSRC extends PanelContainer


func _process(delta):
	if visible:
		pass

func add_property(title:String, value, order):
	var target
	target = $MarginContainer/VBoxContainer.find_child(title, true, false)
	if !target:
		target = Label.new()
		$MarginContainer/VBoxContainer.add_child(target)
		target.name = title
		target.text = title + ": " + str(value)
	elif visible:
		target.text = title + ": " + str(value)
		$MarginContainer/VBoxContainer.move_child(target, order)
              GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�$�n윦���z�x����դ�<����q����F��Z��?&,
ScI_L �;����In#Y��0�p~��Z��m[��N����R,��#"� )���d��mG�������ڶ�$�ʹ���۶�=���mϬm۶mc�9��z��T��7�m+�}�����v��ح�m�m������$$P�����එ#���=�]��SnA�VhE��*JG�
&����^x��&�+���2ε�L2�@��		��S�2A�/E���d"?���Dh�+Z�@:�Gk�FbWd�\�C�Ӷg�g�k��Vo��<c{��4�;M�,5��ٜ2�Ζ�yO�S����qZ0��s���r?I��ѷE{�4�Ζ�i� xK�U��F�Z�y�SL�)���旵�V[�-�1Z�-�1���z�Q�>�tH�0��:[RGň6�=KVv�X�6�L;�N\���J���/0u���_��U��]���ǫ)�9��������!�&�?W�VfY�2���༏��2kSi����1!��z+�F�j=�R�O�{�
ۇ�P-�������\����y;�[ ���lm�F2K�ޱ|��S��d)é�r�BTZ)e�� ��֩A�2�����X�X'�e1߬���p��-�-f�E�ˊU	^�����T�ZT�m�*a|	׫�:V���G�r+�/�T��@U�N׼�h�+	*�*sN1e�,e���nbJL<����"g=O��AL�WO!��߈Q���,ɉ'���lzJ���Q����t��9�F���A��g�B-����G�f|��x��5�'+��O��y��������F��2�����R�q�):VtI���/ʎ�UfěĲr'�g�g����5�t�ۛ�F���S�j1p�)�JD̻�ZR���Pq�r/jt�/sO�C�u����i�y�K�(Q��7őA�2���R�ͥ+lgzJ~��,eA��.���k�eQ�,l'Ɨ�2�,eaS��S�ԟe)��x��ood�d)����h��ZZ��`z�պ��;�Cr�rpi&��՜�Pf��+���:w��b�DUeZ��ڡ��iA>IN>���܋�b�O<�A���)�R�4��8+��k�Jpey��.���7ryc�!��M�a���v_��/�����'��t5`=��~	`�����p\�u����*>:|ٻ@�G�����wƝ�����K5�NZal������LH�]I'�^���+@q(�q2q+�g�}�o�����S߈:�R�݉C������?�1�.��
�ڈL�Fb%ħA ����Q���2�͍J]_�� A��Fb�����ݏ�4o��'2��F�  ڹ���W�L |����YK5�-�E�n�K�|�ɭvD=��p!V3gS��`�p|r�l	F�4�1{�V'&����|pj� ߫'ş�pdT�7`&�
�1g�����@D�˅ �x?)~83+	p �3W�w��j"�� '�J��CM�+ �Ĝ��"���4� ����nΟ	�0C���q'�&5.��z@�S1l5Z��]�~L�L"�"�VS��8w.����H�B|���K(�}
r%Vk$f�����8�ڹ���R�dϝx/@�_�k'�8���E���r��D���K�z3�^���Vw��ZEl%~�Vc���R� �Xk[�3��B��Ğ�Y��A`_��fa��D{������ @ ��dg�������Mƚ�R�`���s����>x=�����	`��s���H���/ū�R�U�g�r���/����n�;�SSup`�S��6��u���⟦;Z�AN3�|�oh�9f�Pg�����^��g�t����x��)Oq�Q�My55jF����t9����,�z�Z�����2��#�)���"�u���}'�*�>�����ǯ[����82һ�n���0�<v�ݑa}.+n��'����W:4TY�����P�ר���Cȫۿ�Ϗ��?����Ӣ�K�|y�@suyo�<�����{��x}~�����~�AN]�q�9ޝ�GG�����[�L}~�`�f%4�R!1�no���������v!�G����Qw��m���"F!9�vٿü�|j�����*��{Ew[Á��������u.+�<���awͮ�ӓ�Q �:�Vd�5*��p�ioaE��,�LjP��	a�/�˰!{g:���3`=`]�2��y`�"��N�N�p���� ��3�Z��䏔��9"�ʞ l�zP�G�ߙj��V�>���n�/��׷�G��[���\��T��Ͷh���ag?1��O��6{s{����!�1�Y�����91Qry��=����y=�ٮh;�����[�tDV5�chȃ��v�G ��T/'XX���~Q�7��+[�e��Ti@j��)��9��J�hJV�#�jk�A�1�^6���=<ԧg�B�*o�߯.��/�>W[M���I�o?V���s��|yu�xt��]�].��Yyx�w���`��C���pH��tu�w�J��#Ef�Y݆v�f5�e��8��=�٢�e��W��M9J�u�}]釧7k���:�o�����Ç����ս�r3W���7k���e�������ϛk��Ϳ�_��lu�۹�g�w��~�ߗ�/��ݩ�-�->�I�͒���A�	���ߥζ,�}�3�UbY?�Ӓ�7q�Db����>~8�]
� ^n׹�[�o���Z-�ǫ�N;U���E4=eȢ�vk��Z�Y�j���k�j1�/eȢK��J�9|�,UX65]W����lQ-�"`�C�.~8ek�{Xy���d��<��Gf�ō�E�Ӗ�T� �g��Y�*��.͊e��"�]�d������h��ڠ����c�qV�ǷN��6�z���kD�6�L;�N\���Y�����
�O�ʨ1*]a�SN�=	fH�JN�9%'�S<C:��:`�s��~��jKEU�#i����$�K�TQD���G0H�=�� �d�-Q�H�4�5��L�r?����}��B+��,Q�yO�H�jD�4d�����0*�]�	~�ӎ�.�"����%
��d$"5zxA:�U��H���H%jس{���kW��)�	8J��v�}�rK�F�@�t)FXu����G'.X�8�KH;���[             [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://xwc3tmg7nbey"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()
  RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    lightmap_size_hint 	   material    custom_aabb    flip_faces    add_uv2    uv2_padding    radius    height    radial_segments    rings    script    custom_solver_bias    margin    points 	   _bundled       Script    res://Player.gd ��������      local://CapsuleMesh_uihck       #   local://ConvexPolygonShape3D_hrpwk 8         local://PackedScene_1w0iy �         CapsuleMesh             ConvexPolygonShape3D       #       D6 ��e������<r��>�m�>?�->$?���>��l>$�M���>��>��&?^y�0���G?e_�=�ɹ� �.�*S�>�&�>6�'�?������A�W?���Ppɾ�/��z��b�>.�?\�M>�U�=m:z?��=����'�y�[_��\M>9)��$���=��o?�-�<�����?"��>K�%"��o��>�k�>h���G�>���=�$?�\��ˡվ:"?�~��j��(��=6�� ;��t�h?�vZ=���Wva�%?R>���> g��s�U4�>T_?�� ��/�>ؼ�������>J
�>n��B�Y= `?y?�>�@�5B����>�:ǽ�HH�L�˾�yƾE�����>��׆�Ǿ         PackedScene          	         names "         Player    script    CharacterBody3D    MeshInstance3D    mesh    CollisionShape3D    shape    TwistPivot    Node3D    PitchPivot 	   Camera3D    	   variants                                          node_count             nodes     0   ��������       ����                            ����                           ����                           ����                  	   ����               
   
   ����              conn_count              conns               node_paths              editable_instances              version             RSRC     RSRC                    PackedScene            ��������                                            �      resource_local_to_scene    resource_name    sky_top_color    sky_horizon_color 
   sky_curve    sky_energy_multiplier 
   sky_cover    sky_cover_modulate    ground_bottom_color    ground_horizon_color    ground_curve    ground_energy_multiplier    sun_angle_max 
   sun_curve    use_debanding    script    sky_material    process_mode    radiance_size    background_mode    background_color    background_energy_multiplier    background_intensity    background_canvas_max_layer    background_camera_feed_id    sky    sky_custom_fov    sky_rotation    ambient_light_source    ambient_light_color    ambient_light_sky_contribution    ambient_light_energy    reflected_light_source    tonemap_mode    tonemap_exposure    tonemap_white    ssr_enabled    ssr_max_steps    ssr_fade_in    ssr_fade_out    ssr_depth_tolerance    ssao_enabled    ssao_radius    ssao_intensity    ssao_power    ssao_detail    ssao_horizon    ssao_sharpness    ssao_light_affect    ssao_ao_channel_affect    ssil_enabled    ssil_radius    ssil_intensity    ssil_sharpness    ssil_normal_rejection    sdfgi_enabled    sdfgi_use_occlusion    sdfgi_read_sky_light    sdfgi_bounce_feedback    sdfgi_cascades    sdfgi_min_cell_size    sdfgi_cascade0_distance    sdfgi_max_distance    sdfgi_y_scale    sdfgi_energy    sdfgi_normal_bias    sdfgi_probe_bias    glow_enabled    glow_levels/1    glow_levels/2    glow_levels/3    glow_levels/4    glow_levels/5    glow_levels/6    glow_levels/7    glow_normalized    glow_intensity    glow_strength 	   glow_mix    glow_bloom    glow_blend_mode    glow_hdr_threshold    glow_hdr_scale    glow_hdr_luminance_cap    glow_map_strength 	   glow_map    fog_enabled    fog_light_color    fog_light_energy    fog_sun_scatter    fog_density    fog_aerial_perspective    fog_sky_affect    fog_height    fog_height_density    volumetric_fog_enabled    volumetric_fog_density    volumetric_fog_albedo    volumetric_fog_emission    volumetric_fog_emission_energy    volumetric_fog_gi_inject    volumetric_fog_anisotropy    volumetric_fog_length    volumetric_fog_detail_spread    volumetric_fog_ambient_inject    volumetric_fog_sky_affect -   volumetric_fog_temporal_reprojection_enabled ,   volumetric_fog_temporal_reprojection_amount    adjustment_enabled    adjustment_brightness    adjustment_contrast    adjustment_saturation    adjustment_color_correction    lightmap_size_hint 	   material    custom_aabb    flip_faces    add_uv2    uv2_padding    size    subdivide_width    subdivide_depth    center_offset    orientation    custom_solver_bias    margin    data    backface_collision 	   _bundled       PackedScene    res://player.tscn ��M��^�E   $   local://ProceduralSkyMaterial_vjxvn 8         local://Sky_252lp �         local://Environment_s0x83 �         local://PlaneMesh_0ihl3       $   local://ConcavePolygonShape3D_dwwhm ,         local://PackedScene_dblk5 �         ProceduralSkyMaterial          �p%?;�'?F�+?  �?	      �p%?;�'?F�+?  �?         Sky                          Environment                         !         C               
   PlaneMesh    w   
     �A  �A         ConcavePolygonShape3D    ~   #        HA      HA  H�      HA  HA      H�  H�      HA  H�      H�  HA      H�         PackedScene    �      	         names "         Node3D    WorldEnvironment    environment    DirectionalLight3D 
   transform    shadow_enabled    MeshInstance3D    mesh    StaticBody3D    CollisionShape3D    shape    Player 
   top_level    	   variants                   г]��ݾ  �>       ?г]?   �  @?�ݾ                                                 \��>            \��>            \��>�dW<f��>��[>      node_count             nodes     ?   ��������        ����                      ����                            ����                                 ����                          ����               	   	   ����   
                 ���                               conn_count              conns               node_paths              editable_instances              version             RSRC              shader_type spatial;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
}

void light() {
	// Called for every pixel for every light affecting the material.
}
               extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
         RSRC                    PackedScene            ��������                                                 resource_local_to_scene    resource_name    interpolation_mode    interpolation_color_space    offsets    colors    script    noise_type    seed 
   frequency    offset    fractal_type    fractal_octaves    fractal_lacunarity    fractal_gain    fractal_weighted_strength    fractal_ping_pong_strength    cellular_distance_function    cellular_jitter    cellular_return_type    domain_warp_enabled    domain_warp_type    domain_warp_amplitude    domain_warp_frequency    domain_warp_fractal_type    domain_warp_fractal_octaves    domain_warp_fractal_lacunarity    domain_warp_fractal_gain    width    height    invert    in_3d_space    generate_mipmaps 	   seamless    seamless_blend_skirt    as_normal_map    bump_strength 
   normalize    color_ramp    noise    render_priority 
   next_pass    transparency    blend_mode 
   cull_mode    depth_draw_mode    no_depth_test    shading_mode    diffuse_mode    specular_mode    disable_ambient_light    disable_fog    vertex_color_use_as_albedo    vertex_color_is_srgb    albedo_color    albedo_texture    albedo_texture_force_srgb    albedo_texture_msdf 	   metallic    metallic_specular    metallic_texture    metallic_texture_channel 
   roughness    roughness_texture    roughness_texture_channel    emission_enabled 	   emission    emission_energy_multiplier    emission_operator    emission_on_uv2    emission_texture    normal_enabled    normal_scale    normal_texture    rim_enabled    rim 	   rim_tint    rim_texture    clearcoat_enabled 
   clearcoat    clearcoat_roughness    clearcoat_texture    anisotropy_enabled    anisotropy    anisotropy_flowmap    ao_enabled    ao_light_affect    ao_texture 
   ao_on_uv2    ao_texture_channel    heightmap_enabled    heightmap_scale    heightmap_deep_parallax    heightmap_flip_tangent    heightmap_flip_binormal    heightmap_texture    heightmap_flip_texture    subsurf_scatter_enabled    subsurf_scatter_strength    subsurf_scatter_skin_mode    subsurf_scatter_texture &   subsurf_scatter_transmittance_enabled $   subsurf_scatter_transmittance_color &   subsurf_scatter_transmittance_texture $   subsurf_scatter_transmittance_depth $   subsurf_scatter_transmittance_boost    backlight_enabled 
   backlight    backlight_texture    refraction_enabled    refraction_scale    refraction_texture    refraction_texture_channel    detail_enabled    detail_mask    detail_blend_mode    detail_uv_layer    detail_albedo    detail_normal 
   uv1_scale    uv1_offset    uv1_triplanar    uv1_triplanar_sharpness    uv1_world_triplanar 
   uv2_scale    uv2_offset    uv2_triplanar    uv2_triplanar_sharpness    uv2_world_triplanar    texture_filter    texture_repeat    disable_receive_shadows    shadow_to_opacity    billboard_mode    billboard_keep_scale    grow    grow_amount    fixed_size    use_point_size    point_size    use_particle_trails    proximity_fade_enabled    proximity_fade_distance    msdf_pixel_range    msdf_outline_size    distance_fade_mode    distance_fade_min_distance    distance_fade_max_distance    rayleigh_coefficient    rayleigh_color    mie_coefficient    mie_eccentricity 
   mie_color 
   turbidity    sun_disk_scale    ground_color    energy_multiplier    use_debanding 
   night_sky    sky_material    process_mode    radiance_size    background_mode    background_color    background_energy_multiplier    background_intensity    background_canvas_max_layer    background_camera_feed_id    sky    sky_custom_fov    sky_rotation    ambient_light_source    ambient_light_color    ambient_light_sky_contribution    ambient_light_energy    reflected_light_source    tonemap_mode    tonemap_exposure    tonemap_white    ssr_enabled    ssr_max_steps    ssr_fade_in    ssr_fade_out    ssr_depth_tolerance    ssao_enabled    ssao_radius    ssao_intensity    ssao_power    ssao_detail    ssao_horizon    ssao_sharpness    ssao_light_affect    ssao_ao_channel_affect    ssil_enabled    ssil_radius    ssil_intensity    ssil_sharpness    ssil_normal_rejection    sdfgi_enabled    sdfgi_use_occlusion    sdfgi_read_sky_light    sdfgi_bounce_feedback    sdfgi_cascades    sdfgi_min_cell_size    sdfgi_cascade0_distance    sdfgi_max_distance    sdfgi_y_scale    sdfgi_energy    sdfgi_normal_bias    sdfgi_probe_bias    glow_enabled    glow_levels/1    glow_levels/2    glow_levels/3    glow_levels/4    glow_levels/5    glow_levels/6    glow_levels/7    glow_normalized    glow_intensity    glow_strength 	   glow_mix    glow_bloom    glow_blend_mode    glow_hdr_threshold    glow_hdr_scale    glow_hdr_luminance_cap    glow_map_strength 	   glow_map    fog_enabled    fog_light_color    fog_light_energy    fog_sun_scatter    fog_density    fog_aerial_perspective    fog_sky_affect    fog_height    fog_height_density    volumetric_fog_enabled    volumetric_fog_density    volumetric_fog_albedo    volumetric_fog_emission    volumetric_fog_emission_energy    volumetric_fog_gi_inject    volumetric_fog_anisotropy    volumetric_fog_length    volumetric_fog_detail_spread    volumetric_fog_ambient_inject    volumetric_fog_sky_affect -   volumetric_fog_temporal_reprojection_enabled ,   volumetric_fog_temporal_reprojection_amount    adjustment_enabled    adjustment_brightness    adjustment_contrast    adjustment_saturation    adjustment_color_correction 	   _bundled       PackedScene     res://addons/fpc/character.tscn mYlN��D      local://Gradient_ur0vy u         local://FastNoiseLite_jd3pw �         local://NoiseTexture2D_7akuf �      !   local://StandardMaterial3D_67ysu G      "   local://PhysicalSkyMaterial_edcox z         local://Sky_2iust �         local://Environment_20rw3 �         local://PackedScene_jbv10 *      	   Gradient       $          b��>�z�<  �?���>I�?X<�=  �?         FastNoiseLite    	      
ף;         NoiseTexture2D                               &             '                     StandardMaterial3D    7                     PhysicalSkyMaterial    �      ��$>��P?��g?  �?         Sky    �                     Environment    �         �            �         �                  PackedScene          	         names "         test_world    Node3D 
   character 	   CSGBox3D 
   transform    use_collision    size 	   material    WorldEnvironment    environment    sun    light_energy    shadow_enabled    DirectionalLight3D    	   variants                      �?              �?              �?       �                A  �?   A                     �,a?��߾pxA>    �V�>��j?%��ΧN�۲>                 �@      node_count             nodes     3   ��������       ����                ���                             ����                                             ����   	                     
   ����                               conn_count              conns               node_paths              editable_instances              version             RSRC        [remap]

path="res://.godot/exported/133200997/export-fc30c6f2d988778d581100b68ad6a198-reticle_0.scn"
          [remap]

path="res://.godot/exported/133200997/export-b5aaf044b72cc3159bdaffa87440fe40-reticle_1.scn"
          [remap]

path="res://.godot/exported/133200997/export-021e70dc9a0e55530b40268847043520-character.scn"
          [remap]

path="res://.godot/exported/133200997/export-36a25e342948d0ceacc500772b5412b3-player.scn"
             [remap]

path="res://.godot/exported/133200997/export-d85448a68f01bbd6644b4b40ef87233e-level.scn"
              [remap]

path="res://.godot/exported/133200997/export-45fcf9618186e808d2822186ae3763f1-test_world.scn"
         list=Array[Dictionary]([])
     <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path fill="#478cbf" d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 813 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H447l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z"/><path d="M483 600c3 34 55 34 58 0v-86c-3-34-55-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
             P�˟MXP(   res://addons/fpc/reticles/reticle_0.tscn(D�N��(   res://addons/fpc/reticles/reticle_1.tscnmYlN��D   res://addons/fpc/character.tscnLԼ�C	   res://icon.svg�j�y{�T   res://test_world.tscn��M��^�E   res://player.tscn-�'�|�e   res://level.tscn     ECFG      application/config/name         New Game Project   application/config/features$   "         4.2    Forward Plus       application/config/icon         res://icon.svg     input/ui_left�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode     @    physical_keycode       	   key_label             unicode           echo          script            InputEventJoypadButton        resource_local_to_scene           resource_name             device            button_index         pressure          pressed           script            InputEventJoypadMotion        resource_local_to_scene           resource_name             device            axis       
   axis_value       ��   script            InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   A   	   key_label             unicode           echo          script         input/ui_right�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode     @    physical_keycode       	   key_label             unicode           echo          script            InputEventJoypadButton        resource_local_to_scene           resource_name             device            button_index         pressure          pressed           script            InputEventJoypadMotion        resource_local_to_scene           resource_name             device            axis       
   axis_value       �?   script            InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   D   	   key_label             unicode           echo          script         input/ui_up�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode     @    physical_keycode       	   key_label             unicode           echo          script            InputEventJoypadButton        resource_local_to_scene           resource_name             device            button_index         pressure          pressed           script            InputEventJoypadMotion        resource_local_to_scene           resource_name             device            axis      
   axis_value       ��   script            InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   W   	   key_label             unicode           echo          script         input/ui_down�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode     @    physical_keycode       	   key_label             unicode           echo          script            InputEventJoypadButton        resource_local_to_scene           resource_name             device            button_index         pressure          pressed           script            InputEventJoypadMotion        resource_local_to_scene           resource_name             device            axis      
   axis_value       �?   script            InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   S   	   key_label             unicode           echo          script         input/move_forward�              events              InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   W   	   key_label             unicode           echo          script            deadzone      ?   input/move_right�              events              InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   D   	   key_label             unicode           echo          script            deadzone      ?   input/move_down�              events              InputEventKey         resource_local_to_scene           resource_name             device         	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   S   	   key_label             unicode           echo          script            deadzone      ?J   rendering/lights_and_shadows/directional_shadow/soft_shadow_filter_quality         '   rendering/anti_aliasing/quality/msaa_3d                   