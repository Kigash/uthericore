table 57050 "Field Coll Return To Chashier"
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
        field(4; "Field Officer User ID"; Text[50])
        {
            Editable = false;
        }
        field(5; "Field Officer Balance"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Ledger Entry".Amount where("Bank Account No." = field("Field Officer No.")));
        }
        field(6; "Till Return Amount"; Decimal)
        {
            trigger OnValidate()
            begin
                CalcFields("Field Officer Balance");
                if "Till Return Amount" > "Field Officer Balance" then
                    Error('return amount cannot exceed available balance');
            end;
        }
        field(7; "No. Series"; Code[20])
        {
        }
        field(9; "Field Officer No."; Code[20])
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
        field(16; "Cashier Account No."; Code[20])
        {
            TableRelation = "Bank Account" where("Account Type" = filter("Till Account"));
        }
        field(17; Reversed; Boolean)
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
        UserNotSetupAsTellerErr: Label 'User %1 has not been setup as a Field Agent';
        TellerNotActivatedErr: Label 'Agent %1 is not active';

    trigger OnInsert()
    begin
        TelleringSetup.GET;
        IF "No." = '' THEN
            "No." := NoSeriesManagement.GetNextNo(TelleringSetup."Teller Return Treasury Nos.");
        GlobalManagement.GetHostInfo(HostName, HostMac, HostIP);
        "Field Officer User ID" := UserId;
        "Transaction Date" := Today;
        "Transaction Time" := Time;
        Description := 'Field Collection Return To Cashier -' + UserId;
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
            "Field Officer No." := TellerUserSetup."Till No.";
        end else
            Error(UserNotSetupAsTellerErr, UserId);

    end;


}