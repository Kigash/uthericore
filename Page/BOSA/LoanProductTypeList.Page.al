page 50213 "Loan Product Type List"
{
    // version TL2.0

    Caption = 'Loan Product Types';
    CardPageID = "Loan Product Type Card";
    PageType = List;
    SourceTable = "Loan Product Type";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = All;
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    ApplicationArea = All;
                }
                field("Grace Period"; Rec."Grace Period")
                {
                    ApplicationArea = All;
                }
                field("Rounding Precision"; Rec."Rounding Precision")
                {
                    ApplicationArea = All;
                }
                field("Min. Loan Amount"; Rec."Min. Loan Amount")
                {
                    ApplicationArea = All;
                }
                field("Max. Loan Amount"; Rec."Max. Loan Amount")
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }

                field("Loan Posting Group"; Rec."Loan Posting Group")
                {
                    ApplicationArea = All;
                }
                /*  field("Loan Account"; Rec."Loan Account")
                 {
                     ApplicationArea = All;
                 } */
                field("Interest Due Posting Group"; Rec."Interest Due Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Interest Paid Posting Group"; Rec."Interest Paid Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Penalty Due Posting Group"; Rec."Penalty Due Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Penalty Paid Posting Group"; Rec."Penalty Paid Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Ledger Fee Due Posting Group"; Rec."Ledger Fee Due Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Ledger Fee Paid Posting Group"; Rec."Ledger Fee Paid Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Repayment Period"; Rec."Repayment Period")
                {
                    ApplicationArea = All;
                }
                field("Min. Membership period"; Rec."Min. Membership period")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    ApplicationArea = All;
                }
                field("E-Loan"; Rec."E-Loan")
                {
                    ApplicationArea = All;
                }
                field("No. of Guarantors"; Rec."No. of Guarantors")
                {
                    ApplicationArea = All;
                }
                field("Recovery Method"; Rec."Recovery Method")
                {
                    ApplicationArea = All;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                }


                field("Security Type"; Rec."Security Type")
                {
                    ApplicationArea = All;
                }
                field("Apply Graduation Schedule"; Rec."Apply Graduation Schedule")
                {
                    ApplicationArea = All;
                }
                field("Allow Refinancing"; Rec."Allow Refinancing")
                {
                    ApplicationArea = All;
                }
                field("Refinancing Mode"; Rec."Refinancing Mode")
                {
                    ApplicationArea = All;
                }

                field("Apply 1/3 Rule"; Rec."Apply 1/3 Rule")
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

