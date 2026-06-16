page 50225 "Loan Refinance Charges"
{
    // version TL2.0

    PageType = List;
    SourceTable = "Loan Refinance Charge";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Minimum Amount Paid %"; Rec."Minimum Amount Paid %")
                {ApplicationArea = All;
                }
                field("Maximum Amount Paid %"; Rec."Maximum Amount Paid %")
                {ApplicationArea = All;
                }
                field("Refinance Rate %"; Rec."Refinance Rate %")
                {ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

