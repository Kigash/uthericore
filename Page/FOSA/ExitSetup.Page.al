page 50237 "Exit Setup"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Exit Setup";
    UsageCategory = Administration;
    ApplicationArea = All;


    layout
    {
        area(content)
        {
            group(General)
            {
                field("Member Exit Nos."; Rec."Member Exit Nos.")
                {
                    ApplicationArea = All;
                }
                field("Member Archive Nos."; Rec."Member Archive Nos.")
                {
                    ApplicationArea = All;
                }
                field("Refund Nos."; Rec."Refund Nos.")
                {
                    ApplicationArea = All;
                }
                field("Insurance Claim Nos."; Rec."Insurance Claim Nos.")
                {
                    ApplicationArea = All;
                }
                field("Attachment Mandatory"; Rec."Attachment Mandatory")
                {
                    ApplicationArea = All;
                }
                field("Refund Shares to Shares"; Rec."Refund Shares to Shares")
                {
                    ApplicationArea = All;
                }
                field("Insurance G/L Account"; Rec."Insurance G/L Account")
                {
                    ApplicationArea = All;
                }
                field("Expense Account Type"; Rec."Expense Account Type")
                {
                    ApplicationArea = All;
                }
                field("Expense Account No."; Rec."Expense Account No.")
                {
                    ApplicationArea = All;
                }
                field("Member Exit Fee"; Rec."Member Exit Fee")
                {
                    ApplicationArea = All;
                }
                field("Income G/L Account"; Rec."Income G/L Account")
                {
                    ApplicationArea = All;
                }
                field("Member Temp With Fee%"; Rec."Member Temp With Fee%")
                {
                    ApplicationArea = All;
                }
                field("Debit FOSA Account Type"; Rec."Debit FOSA Account Type")
                {
                    ApplicationArea = All;
                }
                field("Credit FOSA Account Type"; Rec."Credit FOSA Account Type")
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
                field("Notification Channel"; Rec."Notification Channel")
                {
                    ApplicationArea = All;
                }
                field("SMS Template"; Rec."SMS Template")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Email Template"; Rec."Email Template")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            group(Posting)
            {
                field("Exit Template Name"; Rec."Exit Template Name")
                {
                    ApplicationArea = All;
                }
                field("Exit Batch Name"; Rec."Exit Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Refund Template Name"; Rec."Refund Template Name")
                {
                    ApplicationArea = All;
                }
                field("Refund Batch Name"; Rec."Refund Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Insurace Claim Template Name"; Rec."Insurace Claim Template Name")
                {
                    ApplicationArea = All;
                }
                field("Insurace Claim Batch Name"; Rec."Insurace Claim Batch Name")
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

