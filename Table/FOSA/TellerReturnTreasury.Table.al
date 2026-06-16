table 50050 "Teller Return Treasury"
{
    DataClassification = ToBeClassified;
    Caption = 'Teller Receive From/Return To Treasury';

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
        field(4; "Teller User ID"; Text[50])
        {
            Editable = false;
        }
        field(5; "Till Balance"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Ledger Entry".Amount where("Bank Account No." = field("Till No.")));
        }
        field(6; "Till Return Amount"; Decimal)
        {

        }
        field(7; "No. Series"; Code[20])
        {
        }
        field(8; "Till Maximum Limit"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Teller User Setup"."Till Maximum Amount" where("User ID" = field("Teller User ID")));
        }
        field(9; "Till No."; Code[20])
        {
            Editable = false;
            TableRelation = "Bank Account";
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
        field(15; Posted; Boolean)
        {
            Editable = false;
        }
        field(16; "Treasury Account No."; Code[20])
        {
            TableRelation = "Bank Account" where("Account Type" = filter("Treasury Account"));
        }
        field(20; "Teller Host IP"; Code[20])
        {
            Editable = false;
        }
        field(21; "Teller Host MAC"; Code[20])
        {
            Editable = false;
        }
        field(22; "Teller Host Name"; Code[30])
        {
            Editable = false;
        }
        field(23; "Transaction Type"; Option)
        {
            OptionCaption = ' ,Receive From Treasury,Return To Treasury';
            OptionMembers = " ","Receive From Treasury","Return To Treasury";
            trigger OnValidate()
            begin
                if "Transaction Type" = "Transaction Type"::"Receive From Treasury" then
                    Description := 'Receive From Treasury';
                if "Transaction Type" = "Transaction Type"::"Return To Treasury" then
                    Description := 'Return To Treasury';
            end;
        }
        field(24; "Till Receive Amount"; Decimal)
        {

        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
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
            "No." := NoSeriesManagement.GetNextNo(TelleringSetup."Teller Return Treasury Nos.");
        GlobalManagement.GetHostInfo(HostName, HostMac, HostIP);

        "Teller Host IP" := HostIP;
        "Teller Host MAC" := HostMac;
        "Teller Host Name" := HostName;
        "Teller User ID" := UserId;
        "Transaction Date" := Today;
        "Transaction Time" := Time;
        Description := 'Return To Treasury';
        ValidateTeller();

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

    local procedure ValidateTeller()
    var

    begin
        if TellerUserSetup.get(UserId) then begin
            if not TellerUserSetup.Active then
                Error(TellerNotActivatedErr, UserId);
            BankAccount.get(TellerUserSetup."Till No.");
            "Till No." := TellerUserSetup."Till No.";
        end else
            Error(UserNotSetupAsTellerErr, UserId);

    end;


}