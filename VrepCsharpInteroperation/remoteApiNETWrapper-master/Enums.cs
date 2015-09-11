using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace remoteApiNETWrapper
{
    public enum sim_api
    {
        errormessage_ignore = 0,
        errormessage_report = 1,
        errormessage_output = 2,
    }

    public enum sim_appobj
    {
        object_type = 109,
        collision_type = 110,
        distance_type = 111,
        simulation_type = 112,
        ik_type = 113,
        constraintsolver_type = 114,
        collection_type = 115,
        ui_type = 116,
        script_type = 117,
        pathplanning_type = 118,
        RESERVED_type = 119,
        texture_type = 120,
    }

    public enum sim_arrayparam
    {
        gravity = 0,
        fog = 1,
        fog_color = 2,
        background_color1 = 3,
        background_color2 = 4,
        ambient_light = 5,
    }

    public enum sim_banner
    {
        left = 1,
        right = 2,
        nobackground = 4,
        overlay = 8,
        followparentvisibility = 16,
        clickselectsparent = 32,
        clicktriggersevent = 64,
        facingcamera = 128,
        fullyfacingcamera = 256,
        backfaceculling = 512,
        keepsamesize = 1024,
        bitmapfont = 2048,
    }

    public enum sim_boolparam
    {
        hierarchy_visible = 0,
        console_visible = 1,
        collision_handling_enabled = 2,
        distance_handling_enabled = 3,
        ik_handling_enabled = 4,
        gcs_handling_enabled = 5,
        dynamics_handling_enabled = 6,
        joint_motion_handling_enabled = 7,
        path_motion_handling_enabled = 8,
        proximity_sensor_handling_enabled = 9,
        vision_sensor_handling_enabled = 10,
        mill_handling_enabled = 11,
        browser_visible = 12,
        scene_and_model_load_messages = 13,
        shape_textures_are_visible = 15,
        display_enabled = 16,
        infotext_visible = 17,
        statustext_open = 18,
        fog_enabled = 19,
        rml2_available = 20,
        rml4_available = 21,
        mirrors_enabled = 22,
        aux_clip_planes_enabled = 23,
        full_model_copy_from_api = 24,
        realtime_simulation = 25,
    }

    public enum sim_buttonproperty
    {
        button = 0,
        label = 1,
        slider = 2,
        editbox = 3,
        staydown = 8,
        enabled = 16,
        borderless = 32,
        horizontallycentered = 64,
        ignoremouse = 128,
        isdown = 256,
        transparent = 512,
        nobackgroundcolor = 1024,
        rollupaction = 2048,
        closeaction = 4096,
        verticallycentered = 8192,
        downupevent = 16384,
    }

    public enum sim_distcalcmethod
    {
        dl = 0,
        dac = 1,
        max_dl_dac = 2,
        dl_and_dac = 3,
        sqrt_dl2_and_dac2 = 4,
        dl_if_nonzero = 5,
        dac_if_nonzero = 6,
    }

    public enum sim_dlgret
    {
        still_open = 0,
        ok = 1,
        cancel = 2,
        yes = 3,
        no = 4,
    }

    public enum sim_dlgstyle
    {
        message = 0,
        input = 1,
        ok = 2,
        ok_cancel = 3,
        yes_no = 4,
        dont_center = 32,
    }

    public enum sim_drawing
    {
        points = 0,
        lines = 1,
        triangles = 2,
        trianglepoints = 3,
        quadpoints = 4,
        discpoints = 5,
        cubepoints = 6,
        spherepoints = 7,
        itemcolors = 32,
        vertexcolors = 64,
        itemsizes = 128,
        backfaceculling = 256,
        wireframe = 512,
        painttag = 1024,
        followparentvisibility = 2048,
        cyclic = 4096,
        _50percenttransparency = 8492,
        _25percenttransparency = 16384,
        _12percenttransparency = 32768,
        emissioncolor = 65536,
        facingcamera = 131072,
        overlay = 262144,
        itemtransparency = 524288,
    }

    public enum sim_floatparam
    {
        rand = 0,
        simulation_time_step = 1,
    }

    public enum sim_gui
    {
        menubar = 1,
        popups = 2,
        toolbar1 = 4,
        toolbar2 = 8,
        hierarchy = 16,
        infobar = 32,
        statusbar = 64,
        scripteditor = 128,
        scriptsimulationparameters = 256,
        dialogs = 512,
        browser = 1024,
        all = 65535,
    }

    public enum sim_ik
    {
        pseudo_inverse_method = 0,
        damped_least_squares_method = 1,
        x_constraint = 1,
        jacobian_transpose_method = 2,
        y_constraint = 2,
        z_constraint = 4,
        alpha_beta_constraint = 8,
        gamma_constraint = 16,
        avoidance_constraint = 64,
    }

    public enum sim_ikresult
    {
        not_performed = 0,
        success = 1,
        fail = 2,
    }

    public enum sim_intparam
    {
        error_report_mode = 0,
        program_version = 1,
        instance_count = 2,
        custom_cmd_start_id = 3,
        compilation_version = 4,
        current_page = 5,
        flymode_camera_handle = 6,
        dynamic_step_divider = 7,
        dynamic_engine = 8,
        server_port_start = 9,
        server_port_range = 10,
        visible_layers = 11,
        infotext_style = 12,
        settings = 13,
        edit_mode_type = 14,
        server_port_next = 15,
        qt_version = 16,
        event_flags_read = 17,
        event_flags_read_clear = 18,
        platform = 19,
        scene_unique_id = 20,
    }

    public enum sim_joint
    {
        revolute_subtype = 10,
        prismatic_subtype = 11,
        spherical_subtype = 12,
    }

    public enum sim_jointmode
    {
        passive = 0,
        motion = 1,
        ik = 2,
        ikdependent = 3,
        dependent = 4,
        force = 5,
    }

    public enum sim_light
    {
        omnidirectional_subtype = 1,
        spot_subtype = 2,
        directional_subtype = 3,
    }

    public enum sim_lua
    {
        arg_nil = 0,
        arg_bool = 1,
        arg_int = 2,
        arg_float = 3,
        arg_string = 4,
        arg_invalid = 5,
        arg_table = 8,
    }

    public enum sim_message
    {
        ui_button_state_change = 0,
        reserved9 = 1,
        object_selection_changed = 2,
        model_loaded = 4,
        reserved11 = 5,
        keypress = 6,
        bannerclicked = 7,
        for_c_api_only_start = 256,
        reserved1 = 257,
        reserved2 = 258,
        reserved3 = 259,
        eventcallback_scenesave = 260,
        eventcallback_modelsave = 261,
        eventcallback_moduleopen = 262,
        eventcallback_modulehandle = 263,
        eventcallback_moduleclose = 264,
        reserved4 = 265,
        reserved5 = 266,
        reserved6 = 267,
        reserved7 = 268,
        eventcallback_instancepass = 269,
        eventcallback_broadcast = 270,
        eventcallback_imagefilter_enumreset = 271,
        eventcallback_imagefilter_enumerate = 272,
        eventcallback_imagefilter_adjustparams = 273,
        eventcallback_imagefilter_reserved = 274,
        eventcallback_imagefilter_process = 275,
        eventcallback_reserved1 = 276,
        eventcallback_reserved2 = 277,
        eventcallback_reserved3 = 278,
        eventcallback_reserved4 = 279,
        eventcallback_abouttoundo = 280,
        eventcallback_undoperformed = 281,
        eventcallback_abouttoredo = 282,
        eventcallback_redoperformed = 283,
        eventcallback_scripticondblclick = 284,
        eventcallback_simulationabouttostart = 285,
        eventcallback_simulationended = 286,
        eventcallback_reserved5 = 287,
        eventcallback_keypress = 288,
        eventcallback_modulehandleinsensingpart = 289,
        eventcallback_renderingpass = 290,
        eventcallback_bannerclicked = 291,
        eventcallback_menuitemselected = 292,
        eventcallback_refreshdialogs = 293,
        eventcallback_sceneloaded = 294,
        eventcallback_modelloaded = 295,
        eventcallback_instanceswitch = 296,
        eventcallback_guipass = 297,
        eventcallback_mainscriptabouttobecalled = 298,
        simulation_start_resume_request = 4096,
        simulation_pause_request = 4097,
        simulation_stop_request = 4098,
    }

    public enum sim_mill
    {
        pyramid_subtype = 40,
        cylinder_subtype = 41,
        disc_subtype = 42,
        cone_subtype = 43,
    }

    public enum sim_modelproperty
    {
        not_collidable = 1,
        not_measurable = 2,
        not_renderable = 4,
        not_detectable = 8,
        not_cuttable = 16,
        not_dynamic = 32,
        not_respondable = 64,
        not_reset = 128,
        not_visible = 256,
        not_model = 61440,
    }

    public enum sim_navigation
    {
        passive = 0,
        camerashift = 1,
        camerarotate = 2,
        camerazoom = 3,
        cameratilt = 4,
        cameraangle = 5,
        camerafly = 6,
        objectshift = 7,
        objectrotate = 8,
        reserved2 = 9,
        reserved3 = 10,
        jointpathtest = 11,
        ikmanip = 12,
        objectmultipleselection = 13,
        reserved4 = 256,
        clickselection = 512,
        ctrlselection = 1024,
        shiftselection = 2048,
        camerazoomwheel = 4096,
        camerarotaterightbutton = 8192,
    }

    public enum sim_object
    {
        shape_type = 0,
        joint_type = 1,
        graph_type = 2,
        camera_type = 3,
        dummy_type = 4,
        proximitysensor_type = 5,
        reserved1 = 6,
        reserved2 = 7,
        path_type = 8,
        visionsensor_type = 9,
        volume_type = 10,
        mill_type = 11,
        forcesensor_type = 12,
        light_type = 13,
        mirror_type = 14,
        type_end = 108,
        no_subtype = 200,
    }

    public enum sim_objectproperty
    {
        reserved1 = 0,
        reserved2 = 1,
        reserved3 = 2,
        reserved4 = 3,
        reserved5 = 4,
        reserved6 = 8,
        collapsed = 16,
        selectable = 32,
        reserved7 = 64,
        selectmodelbaseinstead = 128,
        dontshowasinsidemodel = 256,
    }

    public enum sim_objectspecialproperty
    {
        collidable = 1,
        measurable = 2,
        detectable_ultrasonic = 16,
        detectable_infrared = 32,
        detectable_laser = 64,
        detectable_inductive = 128,
        detectable_capacitive = 256,
        detectable_all = 496,
        renderable = 512,
        cuttable = 1024,
        pathplanning_ignored = 2048,
    }

    public enum sim_particle
    {
        points1 = 0,
        points2 = 1,
        points4 = 2,
        roughspheres = 3,
        spheres = 4,
        respondable1to4 = 32,
        respondable5to8 = 64,
        particlerespondable = 128,
        ignoresgravity = 256,
        invisible = 512,
        itemsizes = 1024,
        itemdensities = 2048,
        itemcolors = 4096,
        cyclic = 8192,
        emissioncolor = 16384,
        water = 32768,
        painttag = 65536,
    }

    public enum sim_pathproperty
    {
        show_line = 1,
        show_orientation = 2,
        closed_path = 4,
        automatic_orientation = 8,
        invert_velocity = 16,
        infinite_acceleration = 32,
        flat_path = 64,
        show_position = 128,
        auto_velocity_profile_translation = 256,
        auto_velocity_profile_rotation = 512,
        endpoints_at_zero = 1024,
        keep_x_up = 2048,
    }

    public enum sim_proximitysensor
    {
        pyramid_subtype = 30,
        cylinder_subtype = 31,
        disc_subtype = 32,
        cone_subtype = 33,
        ray_subtype = 34,
    }

    public enum sim_script
    {
        no_error = 0,
        main_script_nonexistent = 1,
        main_script_not_called = 2,
        reentrance_error = 4,
        lua_error = 8,
        call_error = 16,
    }

    public enum sim_scripttype
    {
        mainscript = 0,
        childscript = 1,
        pluginscript = 2,
        threaded = 240,
    }

    public enum sim_shape
    {
        simpleshape_subtype = 20,
        multishape_subtype = 21,
    }

    public enum sim_simulation
    {
        stopped = 0,
        paused = 8,
        advancing = 16,
        advancing_firstafterstop = 16,
        advancing_running = 17,
        advancing_lastbeforepause = 19,
        advancing_firstafterpause = 20,
        advancing_abouttostop = 21,
        advancing_lastbeforestop = 22,
    }

    public enum sim_stringparam
    {
        application_path = 0,
    }

    public enum sim_ui
    {
        property_visible = 1,
        menu_title = 1,
        property_visibleduringsimulationonly = 2,
        menu_minimize = 2,
        property_moveable = 4,
        menu_close = 4,
        property_relativetoleftborder = 8,
        menu_systemblock = 8,
        property_fixedwidthfont = 32,
        property_systemblock = 64,
        property_settocenter = 128,
        property_relativetotopborder = 256,
        property_rolledup = 256,
        property_selectassociatedobject = 512,
        property_visiblewhenobjectselected = 1024,
    }

    public enum simx_cmdheaderoffset
    {
        mem_size = 0,
        full_mem_size = 4,
        pdata_offset0 = 8,
        pdata_offset1 = 10,
        cmd = 14,
        delay_or_split = 18,
        sim_time = 20,
        status = 24,
        reserved = 25,
    }

    public enum simx_error
    {
        noerror = 0,
        novalue_flag = 1,
        timeout_flag = 2,
        illegal_opmode_flag = 4,
        remote_error_flag = 8,
        split_progress_flag = 16,
        local_error_flag = 32,
        initialize_error_flag = 64,
    }

    public enum simx_headeroffset
    {
        crc = 0,
        version = 2,
        message_id = 3,
        client_time = 7,
        server_time = 11,
        scene_id = 15,
        server_state = 17,
    }

    public enum simx_opmode
    {
        oneshot = 0,
        oneshot_wait = 65536,
        streaming = 131072,
        continuous = 131072,
        oneshot_split = 196608,
        continuous_split = 262144,
        streaming_split = 262144,
        discontinue = 327680,
        buffer = 393216,
        remove = 458752,
    }
}