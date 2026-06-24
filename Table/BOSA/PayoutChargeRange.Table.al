table 57125 "Payout Charge Range"
{
    DataClassification = CustomerContent;
    Caption = 'Payout Charge Range';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "Payout Header";
        }
        field(5; "Line No."; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(10; "Minimum Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Minimum Amount';
        }
        field(15; "Maximum Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Maximum Amount';
        }
        field(20; "Charge Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Charge Amount';
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
