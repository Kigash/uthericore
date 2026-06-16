page 50198 "Loan Application Setup"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Loan Application Setup";
    UsageCategory = Administration;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Loan Application Nos."; Rec."Loan Application Nos.")
                {
                    ApplicationArea = All;
                }
                field("Loan Product Nos."; Rec."Loan Product Nos.")
                {
                    ApplicationArea = All;
                }
                field("Loan Overpayment (Account Type)"; Rec."Loan Overpayment (Account Type)")
                {
                    ApplicationArea = All;
                }
                field("Penalty Calculation Method"; Rec."Penalty Calculation Method")
                {
                    ApplicationArea = All;
                }
                field("Penalty Value"; Rec."Penalty Value")
                {
                    ApplicationArea = All;
                }
                field("Topup Charge Method"; Rec."Topup Charge Method")
                {
                    ApplicationArea = All;
                }
                field("TopUp Charge Value"; Rec."TopUp Charge Value")
                {
                    ApplicationArea = All;
                }
                field("ToopUp Charge Account"; Rec."ToopUp Charge Account")
                {
                    ApplicationArea = All;
                }
                field("Cheque Charge Value"; Rec."Cheque Charge Value")
                {
                    ApplicationArea = All;
                }
                field("Cheque Charge Account"; Rec."Cheque Charge Account")
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
                field("Email Template (Pending Appr.)"; Rec."Email Template (Pending Appr.)")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("SMS Template (Pending Appr.)"; Rec."SMS Template (Pending Appr.)")
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
                field("Email Template (Rejected)"; Rec."Email Template (Rejected)")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("SMS Template (Rejected)"; Rec."SMS Template (Rejected)")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("SMS Template (Cleared)"; Rec."SMS Template (Cleared)")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("SMS Template (Disbursed)"; Rec."SMS Template (Disbursed)")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }

                field("Notify Guarantor"; Rec."Notify Guarantor")
                {
                    ApplicationArea = All;
                }
                field("Email Template (Guarantor)-New"; Rec."Email Template (Guarantor)-New")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("SMS Template (Guarantor)-New"; Rec."SMS Template (Guarantor)-New")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Email Template (Guarantor)-Approved"; Rec."Email Template (Guarantor)-Approved")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("SMS Template (Guarantor)-Approved"; Rec."SMS Template (Guarantor)-Approved")
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

                field("Loan Disbursal Template Name"; Rec."Loan Disbursal Template Name")
                {
                    ApplicationArea = All;
                }
                field("Loan Disbursal Batch Name"; Rec."Loan Disbursal Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Loan Interest Template Name"; Rec."Loan Interest Template Name")
                {
                    ApplicationArea = All;
                }
                field("Loan Interest Batch Name"; Rec."Loan Interest Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Ledger Fee Template Name"; Rec."Ledger Fee Template Name")
                {
                    ApplicationArea = All;
                }
                field("Ledger Fee Batch Name"; Rec."Ledger Fee Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Penalty Template Name"; Rec."Penalty Template Name")
                {
                    ApplicationArea = All;
                }
                field("Penalty Batch Name"; Rec."Penalty Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Loan Recovery Template Name"; Rec."Loan Recovery Template Name")
                {
                    ApplicationArea = All;
                }
                field("Loan Recovery Batch Name"; Rec."Loan Recovery Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Loan Repayment Template Name"; Rec."Loan Repayment Template Name")
                {
                    ApplicationArea = All;
                }
                field("Loan Repayment Batch Name"; Rec."Loan Repayment Batch Name")
                {
                    ApplicationArea = All;
                }
                field("Loan Overpayment Template Name"; Rec."Loan Overpayment Template Name")
                {
                    ApplicationArea = All;
                }
                field("Loan Overpayment Batch Name"; Rec."Loan Overpayment Batch Name")
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

