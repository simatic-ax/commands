// USING Simatic.Ax.Commands;
// USING AxUnit.Assert;

// NAMESPACE Simatic.Ax.Commands.Tests

//     {TestFixture}
//     CLASS Test

//         VAR
//             o : CountValueUntilLimit;
//             oStateless : CountValueUntilLimit;
//             command : itfCommand;
//         END_VAR
        
//         {TestSetup}
//         METHOD PUBLIC TestSetup
//             o := oStateless;
//         END_METHOD

//         {Test}
//         METHOD PUBLIC Start_and_expect_busy_and_count_value_1
//             o.Limit := 5;
//             o.Busy();
//             command := o.Start();
//             IF (command.Busy()) THEN
//                 ;
//             ELSIF command.Error() THEN
//                 ;
//             ELSIF command.Done() THEN
//                 ;
//             END_IF;

//             Equal(expected := FALSE, actual := command.Done());
//             Equal(expected := TRUE, actual := command.Busy());
//             Equal(expected := FALSE, actual := command.Error());
//             Equal(expected := 1, actual := o.GetValue());
//         END_METHOD

//         {Test}
//         METHOD PUBLIC MyTestMethod
//             o.Limit := 5;
//             IF (o.Busy()) THEN
//                 ;
//             ELSIF o.Error() THEN
//                 ;
//             ELSIF o.Done() THEN
//                 ;
//             END_IF;

//             Equal(expected := FALSE, actual := o.Done());
//             Equal(expected := FALSE, actual := o.Busy());
//             Equal(expected := FALSE, actual := o.Error());
//             Equal(expected := 0, actual := o.GetValue());

//         END_METHOD
//     END_CLASS

//     CLASS CountValueUntilLimit
//         EXTENDS ExecuteCommand
//         VAR PUBLIC
//             Limit : DINT;
//         END_VAR
//         VAR
//             m_cmd : OnExecuteCountUntilLimit;
//         END_VAR

//         METHOD PUBLIC Start : itfCommand
//             m_cmd.SetpointLimit := Limit;
//             THIS.ExecuteWithRisingEdge();
//             Start := THIS;
//         END_METHOD

//         METHOD PUBLIC GetValue : DINT
//             GetValue := m_cmd.countValue;
//         END_METHOD

//         METHOD PROTECTED OVERRIDE SetExecute
//             VAR_INPUT
//                 exec : BOOL;
//             END_VAR
//             m_cmd.execute := exec;
//             ;
//         END_METHOD

//         METHOD PROTECTED OVERRIDE Execute
//             m_cmd(
//                 // Busy => _Busy,
//                 Done => _Done,
//                 Error => _Error);
//         END_METHOD

//     END_CLASS

//     FUNCTION_BLOCK OnExecuteCountUntilLimit
//         VAR_INPUT
//             execute : BOOL;
//             SetpointLimit : DINT;
//         END_VAR
//         VAR_OUTPUT
//             countValue : DINT;
//             busy : BOOL;
//             done : BOOL;
//             error : BOOL;
//         END_VAR
//         VAR
//             executeOld : BOOL;
//             internalLimit : DINT;
//         END_VAR
//         VAR_TEMP
//             executeRis : BOOL;
//         END_VAR
//         executeRis := execute AND NOT (executeOld);
//         executeOld := execute;
//         IF (executeRis AND NOT (busy)) THEN
//             busy := TRUE;
//             done := FALSE;
//             error := FALSE;
//             countValue := DINT#0;
//             internalLimit := SetpointLimit;
//         END_IF;
//         IF (countValue >= internalLimit AND busy) THEN
//             busy := FALSE;
//             done := TRUE;
//             error := FALSE;
//         END_IF;
//         IF (busy) THEN
//             countValue := countValue + DINT#1;
//         END_IF;
//     END_FUNCTION_BLOCK

// END_NAMESPACE
