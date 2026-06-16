page 51605 "Loan Restructuring Setup"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Loan Restructuring Setup";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {


                field("Loan Rescheduling Nos."; Rec."Loan Restructuring Nos.")
                {
                    ApplicationArea = All;
                }

                field("Restructuring Type"; Rec."Restructuring Type")
                {
                    ApplicationArea = All;
                }
                field("Restructuring Method"; Rec."Restructuring Method")
                {
                    ApplicationArea = All;
                }
                field("Loan Balancing %"; Rec."Loan Balancing %")
                {
                    ApplicationArea = All;
                }
                field("Loan Balancing Income A/c"; Rec."Loan Balancing Income A/c")
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
                field("Email Template (Pending Appr.)"; Rec."Email Template (Pending Appr.)")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("SMS Template (Pending Appr.)"; Rec."SMS Template (Pending Appr.)")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Email Template (Approved)"; Rec."Email Template (Approved)")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("SMS Template (Approved)"; Rec."SMS Template (Approved)")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Email Template (Rejected)"; Rec."Email Template (Rejected)")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("SMS Template (Rejected)"; Rec."SMS Template (Rejected)")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }

            }
            group(Posting)
            {

                field("Loan Restr. Template Name"; Rec."Loan Restr. Template Name")
                {
                    ApplicationArea = All;
                }

                field("Loan Restr. Batch Name"; Rec."Loan Restr. Batch Name")
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

