USING Simatic.Ax.Commands;
USING AxUnit.Assert;

NAMESPACE Simatic.Ax.Actuators

    FUNCTION_BLOCK ActuatorWithFeedback
        VAR_INPUT
            execute : BOOL;
            feedback : BOOL;
        END_VAR
        VAR_OUTPUT
            busy : BOOL;
            done : BOOL;
            error : BOOL;
            control : BOOL;
        END_VAR
        VAR
            executeOld : BOOL;
            state : INT;
        END_VAR
        VAR_TEMP
            executeRis : BOOL;
        END_VAR
        VAR CONSTANT
            STATE_IDLE : INT := 0;
            STATE_BUSY : INT := 1;
            STATE_DONE : INT := 2;
            STATE_ERROR : INT := 3;
        END_VAR
        
        executeRis := execute AND NOT(executeRis);
        executeOld := execute;
        
        CASE state OF
            STATE_IDLE: 
                control := FALSE;
                busy := FALSE;
                error := FALSE;
                done := FALSE;
                IF (executeRis) THEN
                    state := STATE_BUSY;
                END_IF;
            STATE_BUSY: 
            control := TRUE;
            busy := TRUE;
                IF (feedback) THEN
                    state := STATE_DONE;
                    busy := FALSE;
                    done := TRUE;
                END_IF;
            STATE_DONE: 
                state := STATE_IDLE;
            STATE_ERROR: ;
        END_CASE;

    END_FUNCTION_BLOCK

END_NAMESPACE
