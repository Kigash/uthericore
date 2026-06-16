page 50333 "Loan Writeoff Setup"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Loan Writeoff Setup";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Loan Writeoff Nos."; Rec."Loan Writeoff Nos.")
                {
                    ApplicationArea = All;
                }
                field("LW G/L Control Account"; Rec."LW G/L Control Account")
                {
                    ApplicationArea = All;
                }
                field("Attachment Mandatory"; Rec."Attachment Mandatory")
                {
                    ApplicationArea = All;
                }
            }
            group(Posting)
            {


                field("Loan Writeoff Template Name"; Rec."Loan Writeoff Template Name")
                {
                    ApplicationArea = All;
                }
                field("Loan Writeoff Batch Name"; Rec."Loan Writeoff Batch Name")
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

