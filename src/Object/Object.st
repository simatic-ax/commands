NAMESPACE Simatic.Ax
    /// Provides basic functionality for programming on a plc
    /// has acces to the protected Methods and "Initializer" of the classes
    CLASS ABSTRACT Object IMPLEMENTS itfObject
        VAR PUBLIC
            
        END_VAR
        VAR PROTECTED
            _isInitialized : BOOL;
            _hasError : BOOL;
            _errorState : WORD;
        END_VAR
        
        METHOD PUBLIC RunCyclic
            IF (NOT _isInitialized) THEN
                THIS._initialize();
                _isInitialized := TRUE;
            END_IF;
           THIS._execute();
            ;
        END_METHOD

        METHOD PROTECTED ABSTRACT _execute
            
        END_METHOD

        METHOD PROTECTED ABSTRACT _initialize
            
        END_METHOD

        METHOD PROTECTED SetError
            VAR_INPUT
                ErrorCode : WORD;
            END_VAR
            _errorState := ErrorCode;
            _hasError := TRUE;
            ;
        END_METHOD

        METHOD PROTECTED SetError
            VAR_INPUT
                Set : BOOL;
            END_VAR
            _hasError := Set;
            ;
        END_METHOD

        // control module has an error
        METHOD PUBLIC HasError : BOOL;
            HasError := _hasError;
        END_METHOD

        METHOD PUBLIC GetErrorStatus : WORD
            GetErrorStatus := _errorState;
        END_METHOD

    END_CLASS
    
END_NAMESPACE