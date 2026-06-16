page 50197 "Loan Selloff Charges"
{
    // version TL2.0

    PageType = List;
    SourceTable = "Loan Selloff Charge";
    UsageCategory = Administration;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Minimum Amount"; Rec."Minimum Amount")
                {
                    ApplicationArea = All;
                }
                field("Maximum Amount"; Rec."Maximum Amount")
                {
                    ApplicationArea = All;
                }
                field("Calculation Method"; Rec."Calculation Method")
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

