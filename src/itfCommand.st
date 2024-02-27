NAMESPACE Simatic.Ax.Commands

    INTERFACE itfCommand
        METHOD Busy : BOOL
        END_METHOD
        METHOD Done : BOOL
        END_METHOD
        METHOD CommandAborted : BOOL
        END_METHOD
        METHOD Error : BOOL
        END_METHOD
        METHOD ErrorID : WORD
        END_METHOD
    END_INTERFACE

END_NAMESPACE
