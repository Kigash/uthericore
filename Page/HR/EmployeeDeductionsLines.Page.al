page 50511 "Employee Deductions Lines"
{
    // version TL2.0

    PageType = ListPart;
    SourceTable = 50258;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field("Asset Tag"; Rec."Asset Tag")
                {
                    ApplicationArea = All;
                }
                field("Serial No"; Rec."Serial No")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}
