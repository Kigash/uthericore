page 50781 "Procurement Contract List"
{
    // version TL2.0

    CardPageID = "Procurement Contract Card";
    PageType = List;
    SourceTable = "Contract Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Process No."; Rec."Process No.")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Award Date"; Rec."Award Date")
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

