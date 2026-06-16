table 50093 Agency
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN
                    "No. Series" := '';
            end;

        }
        field(2; "Member No."; Code[20])
        {
            TableRelation = Member;


        }
        field(3; "Member Name"; Text[50])
        {
            Editable = false;
        }
        field(4; "Account No."; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(5; "Account Name"; Text[50])
        {
            Editable = false;
        }
        field(6; "Created Date"; Date)
        {
            Editable = false;
        }
        field(7; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Active,Inactive';
            OptionMembers = Active,Inactive;
        }
        field(8; Location; Code[20])
        {

        }
        field(9; "Business Name"; Code[20])
        {

        }
        field(10; "Phone No."; Code[20])
        {

        }
        field(11; "Created By"; Code[30])
        {
            Editable = false;
        }
        field(12; "No. Series"; Code[20])
        {
        }
        field(13; "Created Time"; Time)
        {
            Editable = false;
        }
        field(14; "Device Phone No."; Code[20])
        {

        }
        field(15; "Device Serial No."; Code[20])
        {

        }
        field(16; "Account Balance"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Ledger Entry".Amount where("Bank Account No." = field("Account No.")));
            Editable = false;
        }
        field(17; "Agent Type"; Option)
        {
            Editable = false;
            OptionCaption = 'Internal,External';
            OptionMembers = Internal,External;
        }
        field(18; "National ID"; Code[20])
        {

        }
        field(19; "Allow Withdrawal"; Boolean)
        {

        }
        field(20; "Allow Deposit"; Boolean)
        {

        }
        field(21; "Allow Ministatement"; Boolean)
        {

        }
        field(22; "Allow Airtime"; Boolean)
        {

        }
        field(23; "Allow Utility Services"; Boolean)
        {

        }
        FIELD(24; "Allow Balance Inquiry"; Boolean)
        {

        }
        field(26; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'Bank Account';
            OptionMembers = "Bank Account";
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
        AgencyBankingSetup: Record "Agency Banking Setup";
        NoSeriesManagement: Codeunit "No. Series";

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            AgencyBankingSetup.Get();
            "No." := NoSeriesManagement.GetNextNo(AgencyBankingSetup."Agent Nos.");
            "Created By" := UserId;
            "Created Date" := Today;
            "Created Time" := Time;
        END;
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