USING Simatic.Ax.Commands;
USING AxUnit.Assert;

NAMESPACE Simatic.Ax.Actuators
    CLASS TwoWayActuator
        VAR PUBLIC
            controlToWorkPos : BOOL;
            feedbackInWorkPos : BOOL;
            controlToHomePos : BOOL;
            feedbackInHomePos: BOOL;
        END_VAR
        VAR PROTECTED
            _toHomePos : ControlUntilSensorHasReached;
            _toWorkPos : ControlUntilSensorHasReached;
        END_VAR

        METHOD PUBLIC Init
            _toWorkPos.Control := REF(controlToWorkPos);
            _toWorkPos.Feedback := REF(feedbackInWorkPos);
            _toHomePos.Control := REF(controlToHomePos);
            _toHomePos.Feedback := REF(feedbackInHomePos);
        END_METHOD

        METHOD PUBLIC GoToWorkPos : itfCommand
            GoToWorkPos := _toWorkPos.Start();
        END_METHOD

        
        METHOD PUBLIC GoToHomePos : itfCommand
            GoToHomePos := _toHomePos.Start();
        END_METHOD

    END_CLASS
END_NAMESPACE
