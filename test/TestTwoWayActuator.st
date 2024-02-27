USING Simatic.Ax.Commands;
USING AxUnit.Assert;

NAMESPACE Simatic.Ax.Actuators.Tests

    {TestFixture}
    CLASS TestTwoWayActuator
        VAR
            o : TwoWayActuator;
            oStateless : TwoWayActuator;
            command : itfCommand;
        END_VAR

        {TestSetup}
        METHOD PUBLIC TestSetup
            o := oStateless;
            o.Init();
        END_METHOD

        {Test}
        METHOD PUBLIC Idle_Actuator_Returns_no_signals
            command := o.GoToWorkPos();
            IF (command = NULL) THEN
                RETURN;
            END_IF;

            Equal(expected := FALSE, actual := command.Done());
            Equal(expected := TRUE, actual := command.Busy());
            Equal(expected := FALSE, actual := command.Error());
            Equal(expected := TRUE, actual := o.controlToWorkPos);
        END_METHOD

        {Test}
        METHOD PUBLIC ToOpenUntilDone
            command := o.GoToWorkPos();

            Equal(expected := FALSE, actual := command.Done());
            Equal(expected := TRUE, actual := command.Busy());
            Equal(expected := FALSE, actual := command.Error());
            Equal(expected := TRUE, actual := o.controlToWorkPos);


            o.feedbackInWorkPos := TRUE;
            command.Busy();
            
            Equal(expected := TRUE, actual := command.Done());
            Equal(expected := FALSE, actual := command.Busy());
            Equal(expected := FALSE, actual := command.Error());
            Equal(expected := FALSE, actual := o.controlToWorkPos);
        END_METHOD

        {Test}
        METHOD PUBLIC Test_Open_close_Sequence
            command := o.GoToWorkPos();
            
            IF (command = NULL) THEN
                RETURN;
                
            END_IF;

            Equal(expected := FALSE, actual := command.Done());
            Equal(expected := TRUE, actual := command.Busy());
            Equal(expected := FALSE, actual := command.Error());
            Equal(expected := TRUE, actual := o.controlToWorkPos);
        END_METHOD

    END_CLASS

END_NAMESPACE
