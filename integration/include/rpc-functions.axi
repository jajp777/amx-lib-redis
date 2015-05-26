(***********************************************************)
(*                         WARNING                         *)
(***********************************************************)
(*  This file is automatically generated.                  *)
(***********************************************************)

/*
Included Files:
---------------
amx-lib-netlinx-integration.axs
include/amx-lib-log/amx-lib-log.axi
include/amx-lib-volume/amx-lib-volume-sc.axi
include/amx-lib-volume/amx-lib-volume.axi
include/rpc-functions.axi
include/ui/_config.axi
../amx-lib-redis.axi


Excluded Files:
---------------
include/rpc.axi

*/


#if_not_defined RPC_FUNCTION_LIST
#define RPC_FUNCTION_LIST 1

DEFINE_EVENT

data_event[vdvRPC]
{
    string:
    {
        char f_name[255];
        f_name = rpc_function_name(data.text);
        
        /*------------------------------------------------------------------/
            FILE: 'amx-lib-netlinx-integration.axs'
        /------------------------------------------------------------------*/

        /*------------------------------------------------------------------/
            FILE: 'include/amx-lib-log/amx-lib-log.axi'
        /------------------------------------------------------------------*/

        // Skipped:
        // print(integer severity, char str[])

        if(compare_string(f_name, 'logsetlevel'))
        {
            print(LOG_LEVEL_INFO, 'RPC: logSetLevel()');
            
            logSetLevel(
                rpc_get_arg_i(1, data.text)
            );
        }

        if(compare_string(f_name, 'logsetdisableprependseverity'))
        {
            print(LOG_LEVEL_INFO, 'RPC: logSetDisablePrependSeverity()');
            
            logSetDisablePrependSeverity(
                rpc_get_arg_i(1, data.text)
            );
        }

        /*------------------------------------------------------------------/
            FILE: 'include/amx-lib-volume/amx-lib-volume-sc.axi'
        /------------------------------------------------------------------*/

        // Skipped:
        // vol_init(volume v, integer lvl, char muteState, integer min, integer max, integer numSteps)

        // Skipped:
        // vol_get_level(volume v)

        // Skipped:
        // vol_get_level_post_mute(volume v)

        // Skipped:
        // vol_get_level_as_byte(volume v)

        // Skipped:
        // vol_get_level_post_mute_as_byte(volume v)

        // Skipped:
        // vol_get_touch_panel_level(volume v)

        // Skipped:
        // vol_set_level(volume v, integer value)

        // Skipped:
        // vol_set_level_as_byte(volume v, char value)

        // Skipped:
        // vol_set_max(volume v, integer value)

        // Skipped:
        // vol_set_max_as_byte(volume v, char value)

        // Skipped:
        // vol_set_min(volume v, integer value)

        // Skipped:
        // vol_set_min_as_byte(volume v, char value)

        // Skipped:
        // vol_mute(volume v)

        // Skipped:
        // vol_unmute(volume v)

        // Skipped:
        // vol_toggle_mute(volume v)

        // Skipped:
        // vol_get_mute_state(volume v)

        // Skipped:
        // vol_set_step(volume v, integer value)

        // Skipped:
        // vol_set_step_as_byte(volume v, char value)

        // Skipped:
        // vol_set_number_of_steps(volume v, integer steps)

        // Skipped:
        // vol_increment(volume v)

        // Skipped:
        // vol_decrement(volume v)

        // Skipped:
        // vol_dim(volume v)

        // Skipped:
        // vol_undim(volume v)

        // Skipped:
        // vol_get_dim_state(volume v)

        // Skipped:
        // vol_get_dim_amount(volume v)

        // Skipped:
        // vol_get_dim_amount_as_byte(volume v)

        // Skipped:
        // vol_set_dim_amount(volume v, integer amount)

        // Skipped:
        // vol_set_dim_amount_as_byte(volume v, char amount)

        // Skipped:
        // vol_array_init(volume v[], integer lvl, char muteState, integer min, integer max, integer numSteps)

        // Skipped:
        // vol_array_get_level(volume v[], integer index)

        // Skipped:
        // vol_array_get_level_as_byte(volume v[], integer index)

        // Skipped:
        // vol_array_set_level(volume v[], integer value)

        // Skipped:
        // vol_array_set_level_as_byte(volume v[], char value)

        // Skipped:
        // vol_array_set_max(volume v[], integer value)

        // Skipped:
        // vol_array_set_max_as_byte(volume v[], char value)

        // Skipped:
        // vol_array_set_min(volume v[], integer value)

        // Skipped:
        // vol_array_set_min_as_byte(volume v[], char value)

        // Skipped:
        // vol_array_set_step(volume v[], integer value)

        // Skipped:
        // vol_array_set_step_as_byte(volume v[], char value)

        // Skipped:
        // vol_array_set_number_of_steps(volume v[], integer steps)

        // Skipped:
        // vol_array_mute(volume v[])

        // Skipped:
        // vol_array_unmute(volume v[])

        // Skipped:
        // vol_array_increment(volume v[])

        // Skipped:
        // vol_array_decrement(volume v[])

        // Skipped:
        // vol_array_dim(volume v[])

        // Skipped:
        // vol_array_undim(volume v[])

        // Skipped:
        // vol_array_set_dim_amount(volume v[], integer amount)

        // Skipped:
        // vol_array_set_dim_amount_as_byte(volume v[], char amount)

        /*------------------------------------------------------------------/
            FILE: 'include/amx-lib-volume/amx-lib-volume.axi'
        /------------------------------------------------------------------*/

        // Skipped:
        // volInit(volume v, integer lvl, char muteState, integer min, integer max, integer numSteps)

        // Skipped:
        // volGetLevel(volume v)

        // Skipped:
        // volGetLevelPostMute(volume v)

        // Skipped:
        // volGetLevelAsByte(volume v)

        // Skipped:
        // volGetLevelPostMuteAsByte(volume v)

        // Skipped:
        // volGetTouchPanelLevel(volume v)

        // Skipped:
        // volSetLevel(volume v, integer value)

        // Skipped:
        // volSetLevelAsByte(volume v, char value)

        // Skipped:
        // volSetMax(volume v, integer value)

        // Skipped:
        // volSetMaxAsByte(volume v, char value)

        // Skipped:
        // volSetMin(volume v, integer value)

        // Skipped:
        // volSetMinAsByte(volume v, char value)

        // Skipped:
        // volMute(volume v)

        // Skipped:
        // volUnmute(volume v)

        // Skipped:
        // volToggleMute(volume v)

        // Skipped:
        // volGetMuteState(volume v)

        // Skipped:
        // volSetStep(volume v, integer value)

        // Skipped:
        // volSetStepAsByte(volume v, char value)

        // Skipped:
        // volSetNumberOfSteps(volume v, integer steps)

        // Skipped:
        // volIncrement(volume v)

        // Skipped:
        // volDecrement(volume v)

        // Skipped:
        // volDim(volume v)

        // Skipped:
        // volUndim(volume v)

        // Skipped:
        // volGetDimState(volume v)

        // Skipped:
        // volGetDimAmount(volume v)

        // Skipped:
        // volGetDimAmountAsByte(volume v)

        // Skipped:
        // volSetDimAmount(volume v, integer amount)

        // Skipped:
        // volSetDimAmountAsByte(volume v, char amount)

        // Skipped:
        // volArrayInit(volume v[], integer lvl, char muteState, integer min, integer max, integer numSteps)

        // Skipped:
        // volArrayGetLevel(volume v[], integer index)

        // Skipped:
        // volArrayGetLevelAsByte(volume v[], integer index)

        // Skipped:
        // volArraySetLevel(volume v[], integer value)

        // Skipped:
        // volArraySetLevelAsByte(volume v[], char value)

        // Skipped:
        // volArraySetMax(volume v[], integer value)

        // Skipped:
        // volArraySetMaxAsByte(volume v[], char value)

        // Skipped:
        // volArraySetMin(volume v[], integer value)

        // Skipped:
        // volArraySetMinAsByte(volume v[], char value)

        // Skipped:
        // volArraySetStep(volume v[], integer value)

        // Skipped:
        // volArraySetStepAsByte(volume v[], char value)

        // Skipped:
        // volArraySetNumberOfSteps(volume v[], integer steps)

        // Skipped:
        // volArrayMute(volume v[])

        // Skipped:
        // volArrayUnmute(volume v[])

        // Skipped:
        // volArrayIncrement(volume v[])

        // Skipped:
        // volArrayDecrement(volume v[])

        // Skipped:
        // volArrayDim(volume v[])

        // Skipped:
        // volArrayUndim(volume v[])

        // Skipped:
        // volArraySetDimAmount(volume v[], integer amount)

        // Skipped:
        // volArraySetDimAmountAsByte(volume v[], char amount)

        /*------------------------------------------------------------------/
            FILE: 'include/rpc-functions.axi'
        /------------------------------------------------------------------*/

        /*------------------------------------------------------------------/
            FILE: 'include/ui/_config.axi'
        /------------------------------------------------------------------*/

        /*------------------------------------------------------------------/
            FILE: '../amx-lib-redis.axi'
        /------------------------------------------------------------------*/

        // Skipped:
        // redis_connect(dev socket, char ip[], integer port)

        // Skipped:
        // redis_get(dev socket, char key[])

        // Skipped:
        // redis_set(dev socket, char key[], char value[])

        // Skipped:
        // redis_subscribe(dev socket, char channel[])

        // Skipped:
        // redis_psubscribe(dev socket, char pattern[])

        // Skipped:
        // redis_unsubscribe(dev socket, char channel[])

        // Skipped:
        // redis_punsubscribe(dev socket, char pattern[])

        // Skipped:
        // redis_unsubscribe_all(dev socket)

        // Skipped:
        // redis_publish(dev socket, char channel[], char message[])

        // Skipped:
        // redis_is_bulk_string(char packet[])

        // Skipped:
        // redis_parse_bulk_string(char packet[], char bulk_string[])

        // Skipped:
        // redis_is_message(char packet[])

        // Skipped:
        // redis_parse_message(char packet[], char channel[], char message[])

        // Skipped:
        // _redis_parse_string_frame(char packet[], char output[], long start)

    }
}
#end_if

