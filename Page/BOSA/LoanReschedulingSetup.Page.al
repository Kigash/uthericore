page 50267 "Loan Rescheduling Setup"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Loan Rescheduling Setup";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {


                field("Loan Rescheduling Nos."; Rec."Loan Rescheduling Nos.")
                {
                    ApplicationArea = All;
                }

                field("Rescheduling Type"; Rec."Rescheduling Type")
                {
                    ApplicationArea = All;
                }
                field("Rescheduling Method"; Rec."Rescheduling Method")
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

                field("Loan Resch. Template Name"; Rec."Loan Resch. Template Name")
                {
                    ApplicationArea = All;
                }

                field("Loan Resch. Batch Name"; Rec."Loan Resch. Batch Name")
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

