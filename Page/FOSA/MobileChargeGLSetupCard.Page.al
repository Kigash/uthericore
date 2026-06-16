page 50561 "Mobile Charge GL Setup Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Mobile Charge GL Setup";
    Caption = 'Mobile Charge GL Setup Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Branch Name"; Rec."Branch Name")
                {
                    ApplicationArea = All;
                }
            }
            group(GLAccounts)
            {
                Caption = 'GL Accounts';
                field("Registration GL Account"; Rec."Registration GL Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'The income GL account used for Registration and Group Registration charges for this branch.';
                }
                field("Penalty GL Account"; Rec."Penalty GL Account")
                {
                    ApplicationArea = All;
                    ToolTip = 'The income GL account used for Penalty charges for this branch.';
                }
            }
        }
    }
}
