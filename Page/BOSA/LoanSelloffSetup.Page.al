page 50312 "Loan Selloff Setup"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Loan Selloff Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Loan Selloff Nos."; Rec."Loan Selloff Nos.")
                {
                    ApplicationArea = All;
                }
                field("Income G/L Account"; Rec."Income G/L Account")
                {
                    ApplicationArea = All;
                }
                field("Attachment Mandatory"; Rec."Attachment Mandatory")
                {
                    ApplicationArea = All;
                }
                field("Receiving Bank Account"; Rec."Receiving Bank Account")
                {
                    ApplicationArea = All;
                }
            }
            group(Posting)
            {
                field("Loan Selloff Template Name"; Rec."Loan Selloff Template Name")
                {
                    ApplicationArea = All;
                }
                field("Loan Selloff Batch Name"; Rec."Loan Selloff Batch Name")
                {
                    ApplicationArea = All;
                }
            }
            group(Notification)
            {
                field("Notify Member"; Rec."Notify Member")
                {
                    ApplicationArea = All;
                }
                field("Email Template"; Rec."Email Template")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("SMS Template"; Rec."SMS Template")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Notification Channel"; Rec."Notification Channel")
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

