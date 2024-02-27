USING Simatic.Ax.Commands;
USING AxUnit.Assert;

NAMESPACE Simatic.Ax.Actuators

    CLASS ControlUntilSensorHasReached
        EXTENDS ExecuteCommand
        VAR PUBLIC
            Feedback : REF_TO BOOL;
            Control : REF_TO BOOL;
        END_VAR
        VAR
            m_Actuator : ActuatorWithFeedback;
        END_VAR

        METHOD PUBLIC Start : itfCommand
            THIS.ExecuteWithRisingEdge();
            Start := THIS;
        END_METHOD

        METHOD PROTECTED OVERRIDE Execute
            m_Actuator(feedback := Feedback^, control => Control^, done => _done, error => _done);
        END_METHOD

        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                exec : BOOL;
            END_VAR
            m_Actuator.execute := TRUE;
            ;
        END_METHOD
    END_CLASS

END_NAMESPACE
