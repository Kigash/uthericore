page 50986 "Boardroom Items Subform"
{
    // version TL2.0

    PageType = ListPart;
    SourceTable = "Boardroom Item";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Item; Rec.Item)
                {
                    ApplicationArea = All;

                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;

                }
                field("No."; Rec."No.")
                {
                    Visible = false;
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
    }
}

