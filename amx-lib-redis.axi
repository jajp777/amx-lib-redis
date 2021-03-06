(***********************************************************
    amx-lib-redis
    v0.1.0
    
    A Redis database client for AMX's NetLinx programming language.
    
    Redis Comamnds:
    http://redis.io/commands
    
    Redis Protocol Specification:
    http://redis.io/topics/protocol
************************************************************
The MIT License (MIT)

Copyright (c) 2015 Alex McLain

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
************************************************************)

#if_not_defined AMX_LIB_REDIS
#define AMX_LIB_REDIS 1
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(*           DEVICE NUMBER DEFINITIONS GO BELOW            *)
(***********************************************************)
DEFINE_DEVICE

(***********************************************************)
(*              CONSTANT DEFINITIONS GO BELOW              *)
(***********************************************************)
DEFINE_CONSTANT

REDIS_DEFAULT_PORT = 6379;

// Error codes.
REDIS_SUCCESS = 0;
REDIS_ERR_INCORRECT_TYPE = 1;

(***********************************************************)
(*                    INCLUDES GO BELOW                    *)
(***********************************************************)

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*              VARIABLE DEFINITIONS GO BELOW              *)
(***********************************************************)
DEFINE_VARIABLE

(***********************************************************)
(*         SUBROUTINE/FUNCTION DEFINITIONS GO BELOW        *)
(***********************************************************)

/*
 *  Connect to a Redis server.
 *  port can be set to REDIS_DEFAULT_PORT.
 */
define_function integer redis_connect(dev socket, char ip[], integer port)
{
    ip_client_open(socket.port, ip, port, IP_TCP);
    
    // TODO: Error handling.
    return REDIS_SUCCESS;
}

/*
 *  Get the value of a key.
 *  http://redis.io/commands/get
 */
define_function integer redis_get(dev socket, char key[])
{
    return _redis_send_command_2(socket, 'GET', key);
}

/*
 *  Set the string value of a key.
 *  http://redis.io/commands/set
 */
define_function integer redis_set(dev socket, char key[], char value[])
{
    return _redis_send_command_3(socket, 'SET', key, value);
}

/*
 *  Subscribes the client to the specified channel.
 *  http://redis.io/commands/subscribe
 */
define_function integer redis_subscribe(dev socket, char channel[])
{
    return _redis_send_command_2(socket, 'SUBSCRIBE', channel);
}

/*
 *  Subscribes the client to the given pattern.
 *  http://redis.io/commands/psubscribe
 */
define_function integer redis_psubscribe(dev socket, char pattern[])
{
    return _redis_send_command_2(socket, 'PSUBSCRIBE', pattern);
}

/*
 *  Unsubscribes the client from the given channel.
 *  http://redis.io/commands/unsubscribe
 */
define_function integer redis_unsubscribe(dev socket, char channel[])
{
    return _redis_send_command_2(socket, 'UNSUBSCRIBE', channel);
}

/*
 *  Unsubscribes the client from all channels.
 *  http://redis.io/commands/unsubscribe
 */
define_function integer redis_unsubscribe_all(dev socket)
{
    return _redis_send_command_1(socket, 'UNSUBSCRIBE');
}

/*
 *  Unsubscribes the client from the given pattern.
 *  http://redis.io/commands/punsubscribe
 */
define_function integer redis_punsubscribe(dev socket, char pattern[])
{
    return _redis_send_command_2(socket, 'PUNSUBSCRIBE', pattern);
}

/*
 *  Unsubscribes the client from all patterns.
 *  http://redis.io/commands/punsubscribe
 */
define_function integer redis_punsubscribe_all(dev socket)
{
    return _redis_send_command_1(socket, 'PUNSUBSCRIBE');
}

/*
 *  Posts a message to the given channel.
 *  http://redis.io/commands/publish
 */
define_function integer redis_publish(dev socket, char channel[], char message[])
{
    return _redis_send_command_3(socket, 'PUBLISH', channel, message);
}

/*
 *  Marks the start of a transaction block. Subsequent commands will be queued
 *  for atomic execution using EXEC.
 *  http://redis.io/commands/multi
 */
define_function integer redis_multi(dev socket)
{
    return _redis_send_command_1(socket, 'MULTI');
}

/*
 *  Executes all previously queued commands in a transaction and restores the
 *  connection state to normal.
 *  http://redis.io/commands/exec
 */
define_function integer redis_exec(dev socket)
{
    return _redis_send_command_1(socket, 'EXEC');
}

/*
 *  Flushes all previously queued commands in a transaction and restores the
 *  connection state to normal. If WATCH was used, DISCARD unwatches all keys
 *  watched by the connection.
 *  http://redis.io/commands/discard
 */
define_function integer redis_discard(dev socket)
{
    return _redis_send_command_1(socket, 'DISCARD');
}

/*
 *  Marks the given keys to be watched for conditional execution of a transaction.
 *  http://redis.io/commands/watch
 */
define_function integer redis_watch(dev socket, char key[])
{
    return _redis_send_command_2(socket, 'WATCH', key);
}

/*
 *  Flushes all the previously watched keys for a transaction.
 *  If you call EXEC or DISCARD, there's no need to manually call UNWATCH.
 *  http://redis.io/commands/unwatch
 */
define_function integer redis_unwatch(dev socket)
{
    return _redis_send_command_1(socket, 'UNWATCH');
}

/*
 *  Parses an OK response packet.
 *  packet - Response from the server.
 */
define_function integer redis_parse_ok(char packet[])
{
    if (
        compare_string(packet, "'+OK', $0D, $0A") == 1 ||
        compare_string(packet, "'*1', $0D, $0A, '+OK', $0D, $0A") == 1
    )
    {
        return REDIS_SUCCESS;
    }
    
    return REDIS_ERR_INCORRECT_TYPE;
}

/*
 *  Parses a nil response packet.
 *  packet - Response from the server.
 */
define_function integer redis_parse_nil(char packet[])
{
    if (compare_string(packet, "'*-1', $0D, $0A") == 1)
    {
        return REDIS_SUCCESS;
    }
    
    return REDIS_ERR_INCORRECT_TYPE;
}

/*
 *  Parses a QUEUED response packet.
 *  packet - Response from the server.
 */
define_function integer redis_parse_queued(char packet[])
{
    if (compare_string(packet, "'+QUEUED', $0D, $0A") == 1)
    {
        return REDIS_SUCCESS;
    }
    
    return REDIS_ERR_INCORRECT_TYPE;
}

/*
 *  Parses a bulk string from a response packet.
 *  packet - Response from the server.
 *  bulk_string - Buffer to store the value.
 */
define_function integer redis_parse_bulk_string(char packet[], char bulk_string[])
{
    integer pos;
    
    if (length_string(packet) < 1 || packet[1] != '$')
    {
        return REDIS_ERR_INCORRECT_TYPE; // Not bulk string.
    }
    
    bulk_string = '';
    pos = _redis_parse_string_frame(packet, bulk_string, 1);
    
    return REDIS_SUCCESS;
}

/*
 *  Parses a pub/sub message from a response packet.
 *  packet - Response from the server.
 *  channel - Buffer to store the channel name.
 *  message - Buffer to store the message.
 */
define_function integer redis_parse_message(char packet[], char channel[], char message[])
{
    integer pos;
    char header[255];
    char trash[255];
    
    // Check for standard message.
    header = "'*3', $0D, $0A, '$7', $0D, $0A, 'message', $0D, $0A";
    
    if (
        length_string(packet) > length_string(header) &&
        compare_string(left_string(packet, length_string(header)), header) == 1
    )
    {
        channel = '';
        message = '';
        pos = _redis_parse_string_frame(packet, channel, length_string(header) + 1);
        pos = _redis_parse_string_frame(packet, message, pos + 1);
        
        return REDIS_SUCCESS;
    }
    
    // Check for pmessage.
    header = "'*4', $0D, $0A, '$8', $0D, $0A, 'pmessage', $0D, $0A";
    
    if (
        length_string(packet) > length_string(header) &&
        compare_string(left_string(packet, length_string(header)), header) == 1
    )
    {
        channel = '';
        message = '';
        pos = _redis_parse_string_frame(packet, trash, length_string(header) + 1); // Throw away subscription pattern.
        pos = _redis_parse_string_frame(packet, channel, pos + 1);
        pos = _redis_parse_string_frame(packet, message, pos + 1);
        
        return REDIS_SUCCESS;
    }
    
    return REDIS_ERR_INCORRECT_TYPE; // Not pub/sub message.
}

/*
 *  Send a command to the Redis server.
 *  socket - TCP connection to the Redis server.
 *  args - Array of strings to send.
 *  
 *  Note: send_string can only transmit 16,000 bytes.
 */
define_function integer _redis_send_command(dev socket, char args[][])
{
    integer i, len;
    char packet[16000]; // send_string can only transmit 16,000 bytes.
    
    packet = "'*', itoa(max_length_array(args)), $0D, $0A"; // Frame size.
    
    for (i = 1, len = max_length_array(args); i <= len; i++)
    {
        packet = "packet, '$', itoa(length_string(args[i])), $0D, $0A"; // String length.
        packet = "packet, args[i], $0D, $0A"; // String content.
    }
    
    send_string socket, packet;
    return REDIS_SUCCESS;
}

/*
 *  Send a command with one argument to the Redis server.
 *  Example: "unsubscribe"
 */
define_function integer _redis_send_command_1(dev socket, char arg1[])
{
    send_string socket, "
        '*1', $0D, $0A,
        '$', itoa(length_string(arg1)), $0D, $0A,
        arg1, $0D, $0A
    ";
    
    return REDIS_SUCCESS;
}

/*
 *  Send a command with two arguments to the Redis server.
 *  Example: "get key"
 */
define_function integer _redis_send_command_2(dev socket, char arg1[], char arg2[])
{
    send_string socket, "
        '*2', $0D, $0A,
        '$', itoa(length_string(arg1)), $0D, $0A,
        arg1, $0D, $0A,
        '$', itoa(length_string(arg2)), $0D, $0A,
        arg2, $0D, $0A
    ";
    
    return REDIS_SUCCESS;
}

/*
 *  Send a command with three arguments to the Redis server.
 *  Example: "set key 10"
 */
define_function integer _redis_send_command_3(dev socket, char arg1[], char arg2[], char arg3[])
{
    send_string socket, "
        '*3', $0D, $0A,
        '$', itoa(length_string(arg1)), $0D, $0A,
        arg1, $0D, $0A,
        '$', itoa(length_string(arg2)), $0D, $0A,
        arg2, $0D, $0A,
        '$', itoa(length_string(arg3)), $0D, $0A,
        arg3, $0D, $0A
    ";
    
    return REDIS_SUCCESS;
}

/*
 *  Parses a string from a Redis response packet.
 *  packet - Response from the server.
 *  output - Buffer to hold the parsed string.
 *  start - Offset to start parsing.
 *  Returns the position of the last byte of the frame.
 */
define_function integer _redis_parse_string_frame(char packet[], char output[], long start)
{
    integer start_pos, end_pos, length;
    
    output = '';
    start_pos = find_string(packet, '$', start);
    end_pos = find_string(packet, "$0D", start_pos);
    length = atoi(mid_string(packet, start_pos, end_pos - start_pos));
    output = mid_string(packet, end_pos + 2, length);
    
    return end_pos + length + 3;
}

(***********************************************************)
(*                 STARTUP CODE GOES BELOW                 *)
(***********************************************************)
DEFINE_START

(***********************************************************)
(*                   THE EVENTS GO BELOW                   *)
(***********************************************************)
DEFINE_EVENT

(***********************************************************)
(*                 THE MAINLINE GOES BELOW                 *)
(***********************************************************)
DEFINE_PROGRAM

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*          DO NOT PUT ANY CODE BELOW THIS COMMENT         *)
(***********************************************************)
#end_if
