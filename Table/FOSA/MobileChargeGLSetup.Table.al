table 50610 "Mobile Charge GL Setup"
{
    DataClassification = CustomerContent;
    Caption = 'Mobile Charge GL Setup';
    LookupPageId = "Mobile Charge GL Setup List";
    DrillDownPageId = "Mobile Charge GL Setup List";

    fields
    {
        field(1; "Branch Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Branch Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            var
                DimValue: Record "Dimension Value";
            begin
                IF DimValue.GET(GetGlobalDim1No(), "Branch Code") THEN
                    "Branch Name" := DimValue.Name;
            end;
        }
        field(2; "Branch Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Branch Name';
            Editable = false;
        }
        field(3; "Registration GL Account"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Registration GL Account';
            TableRelation = "G/L Account"."No." WHERE("Account Type" = CONST(Posting), Blocked = CONST(false));

            trigger OnValidate()
            var
                GLAcc: Record "G/L Account";
            begin
                IF "Registration GL Account" <> '' THEN BEGIN
                    GLAcc.GET("Registration GL Account");
                    GLAcc.TESTFIELD("Account Type", GLAcc."Account Type"::Posting);
                    GLAcc.TESTFIELD(Blocked, FALSE);
                END;
            end;
        }
        field(4; "Penalty GL Account"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Penalty GL Account';
            TableRelation = "G/L Account"."No." WHERE("Account Type" = CONST(Posting), Blocked = CONST(false));

            trigger OnValidate()
            var
                GLAcc: Record "G/L Account";
            begin
                IF "Penalty GL Account" <> '' THEN BEGIN
                    GLAcc.GET("Penalty GL Account");
                    GLAcc.TESTFIELD("Account Type", GLAcc."Account Type"::Posting);
                    GLAcc.TESTFIELD(Blocked, FALSE);
                END;
            end;
        }
    }

    keys
    {
        key(Key1; "Branch Code")
        {
            Clustered = true;
        }
    }

    local procedure GetGlobalDim1No(): Code[20]
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        GeneralLedgerSetup.GET();
        EXIT(GeneralLedgerSetup."Global Dimension 1 Code");
    end;

    trigger OnInsert()
    begin
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
