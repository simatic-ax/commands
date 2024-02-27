NAMESPACE Simatic.Ax.Commands

    CLASS ABSTRACT Command
        IMPLEMENTS itfCommand
        VAR PROTECTED
            _Done : BOOL;
            _CommandAborted : BOOL;
            _Error : BOOL;
            _ErrorID : WORD;           
        END_VAR

        METHOD PUBLIC Busy : BOOL
            THIS.ExecuteIfBusy(); // execute as long it is busy
            Busy := THIS.IsBusy(); // check, if it is still busy
        END_METHOD

        METHOD PUBLIC Done : BOOL
            THIS.ExecuteIfBusy();
            Done := _Done;
        END_METHOD

        METHOD PUBLIC CommandAborted : BOOL
            THIS.ExecuteIfBusy();
            CommandAborted := _CommandAborted;
        END_METHOD

        METHOD PUBLIC ErrorID : WORD
            THIS.ExecuteIfBusy();
            ErrorID := _ErrorID;
        END_METHOD

        METHOD PUBLIC Error : BOOL
            THIS.ExecuteIfBusy();
            Error := _Error;
        END_METHOD

        METHOD PROTECTED ABSTRACT Execute
        END_METHOD

        METHOD PROTECTED InitState
            _Done := FALSE;
            _CommandAborted := FALSE;
            _Error := FALSE;
            _ErrorID := word#0;
        END_METHOD

        METHOD PROTECTED ExecuteIfBusy
            IF THIS.IsBusy() THEN
                THIS.Execute();
            END_IF;
        END_METHOD

        METHOD PROTECTED IsBusy : BOOL
            IsBusy := NOT (_Done OR _Error OR _CommandAborted);
        END_METHOD

        METHOD PROTECTED SetDone
            _Done := TRUE;
            _Error := FALSE;
            _ErrorID := WORD#0000;
            _CommandAborted := FALSE;
        END_METHOD

        METHOD PROTECTED SetError
            VAR_INPUT
                ErrorID : WORD := WORD#16#0000;
            END_VAR
            _Error := TRUE;
            _ErrorID := ErrorID;
            _Done := FALSE;
            _CommandAborted := FALSE;
        END_METHOD

        METHOD PROTECTED SetAborted
            _CommandAborted := TRUE;
            _Error := FALSE;
            _Done := FALSE;
            _ErrorID := WORD#0000;
        END_METHOD
    END_CLASS

END_NAMESPACE
