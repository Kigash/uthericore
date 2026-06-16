page 50014 "Account Opening Setup"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Account Opening Setup";
    UsageCategory = Administration;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Account No. Format"; Rec."Account No. Format")
                {
                    ApplicationArea = All;
                }

                field("Account Opening Nos."; Rec."Account Opening Nos.")
                {
                    ApplicationArea = All;
                }
                field("Account Activation Nos."; Rec."Account Activation Nos.")
                {
                    ApplicationArea = All;
                }
                field("Closing Account Nos."; Rec."Closing Account Nos.")
                {
                    ApplicationArea = All;
                }
                field("Closure Fee GL Account"; Rec."Closure Fee GL Account")
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
                field("Email Template (PendingApprov)"; Rec."Email Template (PendingApprov)")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("SMS Template (PendingApprov)"; Rec."SMS Template (PendingApprov)")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Email Template (Approved)"; Rec."Email Template (Approved)")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("SMS Template (Approved)"; Rec."SMS Template (Approved)")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Email Template (Additional)"; Rec."Email Template (Additional)")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("SMS Template (Additional)"; Rec."SMS Template (Additional)")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Notification Channel"; Rec."Notification Channel")
                {
                    ApplicationArea = All;
                }
            }
            group(Posting)
            {
                field("Ledger Fee Template Name"; Rec."Ledger Fee Template Name")
                {
                    ApplicationArea = All;
                }
                field("Ledger Fee Batch Name"; Rec."Ledger Fee Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Fixed/Call Dep. Template Name"; Rec."Fixed/Call Dep. Template Name")
                {
                    ApplicationArea = All;
                }
                field("Fixed/Call Dep. Batch Name"; Rec."Fixed/Call Dep. Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Account Closure Template Name"; Rec."Account Closure Template Name")
                {
                    ApplicationArea = All;
                }
                field("Account Closure Batch Name"; Rec."Account Closure Batch Name")
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

