table 50096 "InterTeller Transfer Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[30])
        {
            Editable = false;

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN
                    "No. Series" := '';
            end;
        }
        field(3; Description; Text[50])
        {

        }
        field(7; "No. Series"; Code[20])
        {
        }
        field(10; "Transaction Date"; Date)
        {
            Editable = false;
        }
        field(11; "Transaction Time"; Time)
        {
            Editable = false;
        }
        field(13; Status; Option)
        {
            Editable = false;
            OptionCaption = 'New,Pending Approval,Approved,Rejected';
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }

    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;
        TelleringSetup: Record "Tellering Setup";
        HostMac: Code[20];
        HostName: Code[20];
        HostIP: Code[20];
        NoSeriesManagement: Codeunit "No. Series";
        BankAccount: Record "Bank Account";
        TellerUserSetup: Record "Teller User Setup";
        GlobalManagement: Codeunit "Global Management";
        UserNotSetupAsTellerErr: Label 'User %1 has not been setup as a Teller';
        TellerNotActivatedErr: Label 'Teller %1 is not active';

    trigger OnInsert()
    begin
        TelleringSetup.GET;
        IF "No." = '' THEN
            "No." := NoSeriesManagement.GetNextNo(TelleringSetup."Inter Teller Transfer Nos");
        GlobalManagement.GetHostInfo(HostName, HostMac, HostIP);
        "Transaction Date" := Today;
        "Transaction Time" := Time;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}