page 50218 "Loan Graduation Schedule"
{
    // version TL2.0

    AutoSplitKey = true;
    PageType = List;
    SourceTable = "Loan Graduation Schedule";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Minimum Loan Amount"; Rec."Minimum Loan Amount")
                {ApplicationArea = All;
                }
                field("Maximum Loan Amount"; Rec."Maximum Loan Amount")
                {ApplicationArea = All;
                }
                field("Minimum Repayment Period"; Rec."Minimum Repayment Period")
                {ApplicationArea = All;
                }
                field("Maximum Repayment Period"; Rec."Maximum Repayment Period")
                {ApplicationArea = All;
                }
                field("Increment Amount"; Rec."Increment Amount")
                {ApplicationArea = All;
                }
                field("Increment Factor"; Rec."Increment Factor")
                {ApplicationArea = All;
                }
                field("Maximum Amount"; Rec."Maximum Amount")
                {ApplicationArea = All;
                }
                field("Incremental Method"; Rec."Incremental Method")
                {ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

