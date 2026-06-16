page 51202 "Route Plan List"
{
    CardPageID = "Route Plan";
    PageType = List;
    SourceTable = "Route Plan";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Sales Person Code"; Rec."Sales Person Code")
                {
                }
                field("Sales Person Name"; Rec."Sales Person Name")
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        Rec.SETRANGE("Created By", USERID);
    end;
}

