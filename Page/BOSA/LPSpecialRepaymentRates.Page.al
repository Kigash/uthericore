page 50215 "LP Special Repayment Rates"
{
    // version TL2.0

    AutoSplitKey = true;
    Caption = 'Special Repayment Rates';
    PageType = List;
    SourceTable = "LP Special Repayment Rate";

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
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = All;
                }
                field("Repayment Period"; Rec."Repayment Period")
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

