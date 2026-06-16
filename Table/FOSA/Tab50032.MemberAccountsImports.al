table 50032 MemberAccountsImports
{
    Caption = 'MemberAccountsImports';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Account No"; Code[100])
        {
            Caption = 'Account No';
            DataClassification = ToBeClassified;
        }
        field(2; "Member No."; Code[100])
        {
            Caption = 'Member No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Member Name"; Code[200])
        {
            Caption = 'Member Name';
            DataClassification = ToBeClassified;
        }
        field(4; "Account Type Code"; Code[10])
        {
            Caption = 'Account Type Code';
            DataClassification = ToBeClassified;
        }
        field(5; "Account Balance"; Decimal)
        {
            Caption = 'Account Decimal';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Account No")
        {
            Clustered = true;
        }
    }
}
