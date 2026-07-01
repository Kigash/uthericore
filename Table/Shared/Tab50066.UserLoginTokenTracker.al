table 50066 "User Login Token Tracker"
{
    Caption = 'User Login Token Tracker';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = User."User Name";
        }
        field(2; "Current Active Token"; Guid)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        // This sets the User ID as the Primary Key and automatically clusters it
        key(PK; "User ID")
        {
            Clustered = true;
        }
    }
}
