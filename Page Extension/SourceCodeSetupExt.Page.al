pageextension 50001 "Source Code Setup Ext" extends "Source Code Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Cost Accounting")

        {
            group(Finance)

            {
                field("Payment Voucher"; Rec."Payment Voucher")
                {
                    ApplicationArea = All;
                }
                field("Receipt Voucher"; Rec."Receipt Voucher")
                {
                    ApplicationArea = All;
                }
                field("PettyCash Voucher"; Rec."PettyCash Voucher")
                {
                    ApplicationArea = All;
                }
                field(Imprest; Rec.Imprest)
                {
                    ApplicationArea = All;
                }
                field("Imprest Surrender"; Rec."Imprest Surrender")
                {
                    ApplicationArea = All;
                }
                field("Salary Advance"; Rec."Salary Advance")
                {
                    ApplicationArea = All;
                }
                field(Checkoff; Rec.Checkoff)
                {
                    ApplicationArea = All;
                }
            }
            group(FOSA)

            {
                field("Member Application"; Rec."Member Application")
                {
                    ApplicationArea = All;
                }
                field("Account Opening"; Rec."Account Opening")
                {
                    ApplicationArea = All;
                }
                field("Fixed Deposit"; Rec."Fixed Deposit")
                {
                    ApplicationArea = All;
                }
                field(Spotcash; Rec.Spotcash)
                {
                    ApplicationArea = All;
                }
                field(ATM; Rec.ATM)
                {
                    ApplicationArea = All;
                }
                field(Teller; Rec.Teller)
                {
                    ApplicationArea = All;
                }
                field(Treasury; Rec.Treasury)
                {
                    ApplicationArea = All;
                }
                field(CTS; Rec.CTS)
                {
                    ApplicationArea = All;
                }
                field(Agency; Rec.Agency)
                {
                    ApplicationArea = All;
                }
                field(Dormancy; Rec.Dormancy)
                {
                    ApplicationArea = All;
                }
            }
            group(BOSA)

            {
                // control with underlying datasource

                field(Loan; Rec.Loan)
                {
                    ApplicationArea = All;
                }

                field("Standing Order"; Rec."Standing Order")
                {
                    ApplicationArea = All;
                }

                field("Fund Transfer"; Rec."Fund Transfer")
                {
                    ApplicationArea = All;
                }
                field("Guarantor Substitution"; Rec."Guarantor Substitution")
                {
                    ApplicationArea = All;
                }
                field("Loan Rescheduling"; Rec."Loan Rescheduling")
                {
                    ApplicationArea = All;
                }
                field("Loan Restructuring"; Rec."Loan Restructuring")
                {
                    ApplicationArea = All;
                }
                field(Payout; Rec.Payout)
                {
                    ApplicationArea = All;
                }
                field("Member Exit"; Rec."Member Exit")
                {
                    ApplicationArea = All;
                }
                field("Loan Recovery"; Rec."Loan Recovery")
                {
                    ApplicationArea = All;
                }
                field("Loan Selloff"; Rec."Loan Selloff")
                {
                    ApplicationArea = All;
                }
                field("Loan Writeoff"; Rec."Loan Writeoff")
                {
                    ApplicationArea = All;
                }
                field("Opening Balance"; Rec."Opening Balance")
                {
                    ApplicationArea = All;
                }
                field(Remittance; Rec.Remittance)
                {
                    ApplicationArea = All;
                }
                field(Refund; Rec.Refund)
                {
                    ApplicationArea = All;
                }
                field(Defaulter; Rec.Defaulter)
                {
                    ApplicationArea = All;
                }
                field("Loan Overpayment"; Rec."Loan Overpayment")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}