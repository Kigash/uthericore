page 50040 "Member Bank Accounts List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Member Bank Account";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = All;

                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;

                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;

                }
                field("Branch Name"; Rec."Branch Name")
                {
                    ApplicationArea = All;

                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;

                }
                field(Default; Rec.Default)
                {
                    ApplicationArea = All;

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}