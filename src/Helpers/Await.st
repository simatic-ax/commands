NAMESPACE Simatic.Ax.Commands

    // Helper function to await the completion of a command and return its state.
    // This is usefull, when you just want to call the command cycically to check the status 
    FUNCTION Await : PlcOpen
        VAR_INPUT
            cmd : itfCommand;
        END_VAR

        IF (NOT cmd.Busy()) THEN
            IF cmd.Done() THEN
                Await := PlcOpen#Done;
                RETURN;
            ELSIF cmd.Error() THEN
                Await := PlcOpen#Error;
                RETURN;
            ELSIF cmd.CommandAborted() THEN
                Await := PlcOpen#Aborted;
                RETURN;
            ELSE
                Await := PlcOpen#Undefined;
                RETURN;
            END_IF;
        ELSE
            Await := PlcOpen#Busy;
            RETURN;
        END_IF;
    END_FUNCTION

    // Enumeration representing the possible states of a PLCOpen command.
    TYPE
        PlcOpen : (Busy, Done, Error, Aborted, Undefined) := Undefined;
    END_TYPE

    // Function which retruns the string of the PLCOpen Status
    FUNCTION ToString : STRING
        VAR_INPUT
            val : PlcOpen;
        END_VAR
        CASE val OF
            PlcOpen#Undefined :
                ToString := 'Undefined';
                RETURN;
            PlcOpen#Busy :
            ToString := 'Busy';
            RETURN;
            PlcOpen#Done :
            ToString := 'Done';
            RETURN;
            PlcOpen#Error :
            ToString := 'Error';
            RETURN;
            PlcOpen#Aborted :
            ToString := 'Aborted';
            RETURN;
           
        END_CASE;
        ;
    END_FUNCTION

END_NAMESPACE
