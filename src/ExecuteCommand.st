NAMESPACE Simatic.Ax.Commands

    CLASS ABSTRACT ExecuteCommand
        EXTENDS Command
        IMPLEMENTS IPlcOpen
        METHOD PROTECTED ABSTRACT SetExecute
            VAR_INPUT
                exec : BOOL;
            END_VAR
        END_METHOD

        METHOD PROTECTED ExecuteWithRisingEdge
            THIS.SetExecute(exec := FALSE);
            THIS.Execute();
            THIS.SetExecute(exec := TRUE);
            THIS.Execute();
        END_METHOD
    END_CLASS

END_NAMESPACE
