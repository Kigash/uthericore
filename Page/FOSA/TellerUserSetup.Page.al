page 50067 "Teller User Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Teller User Setup";

    layout
    {
        area(Content)
        {
            repeater(TellerUser)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;

                }
                field("Till No."; Rec."Till No.")
                {
                    ApplicationArea = All;

                }
                field("Treasury Account No."; Rec."Treasury Account No.")
                {
                    ApplicationArea = All;

                }
                field("Maximum Withdrawal"; Rec."Maximum Withdrawal")
                {
                    ApplicationArea = All;

                }
                field("Maximum Deposit"; Rec."Maximum Deposit")
                {
                    ApplicationArea = All;

                }
                field("Withdrawal Allowed"; Rec."Withdrawal Allowed")
                {
                    ApplicationArea = All;

                }
                field("Withdrawal Limit (Approval)"; Rec."Withdrawal Limit (Approval)")
                {
                    ApplicationArea = All;

                }
                field("Deposit Limit (Approval)"; Rec."Deposit Limit (Approval)")
                {
                    ApplicationArea = All;

                }
                field("Till Minimum Amount"; Rec."Till Minimum Amount")
                {
                    ApplicationArea = All;

                }
                field("Till Maximum Amount"; Rec."Till Maximum Amount")
                {
                    ApplicationArea = All;

                }
                field("Till Replenishment Level"; Rec."Till Replenishment Level")
                {
                    ApplicationArea = All;

                }

                field("Deposit Allowed"; Rec."Deposit Allowed")
                {
                    ApplicationArea = All;

                }
                field("Cheque Deposit Allowed"; Rec."Cheque Deposit Allowed")
                {
                    ApplicationArea = All;

                }
                field(Active; Rec.Active)
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