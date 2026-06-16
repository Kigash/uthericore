table 50051 GroupBalances
{
    Caption = 'GroupBalances';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Member No."; Code[20])
        {
            Caption = 'Member No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Member Name"; Text[200])
        {
            Caption = 'Member Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Ordinary Balance"; Decimal)
        {
            Caption = 'Ordinary Balance';
            DataClassification = ToBeClassified;
        }
        field(4; "Shares Balance"; Decimal)
        {
            Caption = 'Shares Balance';
            DataClassification = ToBeClassified;
        }
        field(5; "Savings Balance"; Decimal)
        {
            Caption = 'Savings Balance';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Member No.")
        {
            Clustered = true;
        }
    }
}
