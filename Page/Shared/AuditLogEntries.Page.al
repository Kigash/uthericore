page 50385 "Audit Log Entries"
{
    // version MC2.0

    Editable = false;
    PageType = List;
    SourceTable = "Audit Log Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                }
                field(Action; Rec.Action)
                {
                }
                field("Table Name"; Rec."Table Name")
                {
                }
                field("Record ID Key"; Rec."Record ID Key")
                {
                }
                field("Field Name"; Rec."Field Name")
                {
                }
                field("Old Value"; Rec."Old Value")
                {
                }
                field("New Value"; Rec."New Value")
                {
                }
                field("Action Date"; Rec."Action Date")
                {
                }
                field("Action Time"; Rec."Action Time")
                {
                }
                field("User ID"; Rec."User ID")
                {
                }
            }
        }
    }

    actions
    {
    }
}

