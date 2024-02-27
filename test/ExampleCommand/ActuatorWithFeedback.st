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
        END_VAR
        VAR_TEMP
            executeRis : BOOL;
        END_VAR
        
        executeRis := execute AND NOT(executeRis);
        executeOld := execute;
        IF executeRis AND NOT(busy) AND NOT(feedback) THEN
            control := TRUE;
            busy := TRUE;
            error := FALSE;
            done := FALSE;
        ELSIF busy AND feedback THEN
            control := FALSE;
            busy := FALSE;
            error := FALSE;
            done := TRUE;
        ELSIF NOT(busy) AND feedback THEN
            error := TRUE;
        END_IF;

    END_FUNCTION_BLOCK

END_NAMESPACE
