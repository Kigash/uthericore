page 50010 "Global Setup"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Global Setup";
    UsageCategory = Administration;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            group(General)
            {




            }
            group(Numbering)
            {

            }
            group("Account Setup")
            {
                field("Excise Duty %"; Rec."Excise Duty %")
                {
                    ApplicationArea = All;
                }
                field("Excise Duty G/L Account"; Rec."Excise Duty G/L Account")
                {
                    ApplicationArea = All;
                }
                field("Withholding Tax %"; Rec."Withholding Tax %")
                {
                    ApplicationArea = All;
                }
                field("Withholding Tax G/L Account"; Rec."Withholding Tax G/L Account")
                {
                    ApplicationArea = All;
                }
                field("Stamp Duty %"; Rec."Stamp Duty %")
                {
                    ApplicationArea = All;
                }
                field("Stamp Duty G/L Account"; Rec."Stamp Duty G/L Account")
                {
                    ApplicationArea = All;
                }
                field("Income Realization Method"; Rec."Income Realization Method")
                {
                    ApplicationArea = All;
                }


            }
            group(Board)
            {
                Caption = 'Board Members Setups';
                field("Board Tax %"; Rec."Board Tax %")
                {
                    ApplicationArea = All;
                }
                field("Board Tax G/L Account"; Rec."Board Tax G/L Account")
                {
                    ApplicationArea = All;
                }
                field("Sitting Allowance G/L"; Rec."Sitting Allowance G/L")
                {
                    ApplicationArea = All;
                }
                field("Transport Reimbursement G/L"; Rec."Transport Reimbursement G/L")
                {
                    ApplicationArea = All;
                }
                field("Board Hospitality G/L"; Rec."Board Hospitality G/L")
                {
                    ApplicationArea = All;
                }
            }
            group("Loan Setups")
            {
                Caption = 'Loan Setups';
                field("Securities Path"; Rec."Securities Path")
                {
                    ApplicationArea = All;
                }
                field("Loan Form Path"; Rec."Loan Form Path")
                {
                    ApplicationArea = All;
                }
                field("Deposit %"; Rec."Deposit %")
                {
                    ApplicationArea = All;
                }
                field("Deposit Figure"; Rec."Deposit Figure")
                {
                    ApplicationArea = All;
                }
                field("Maximum Deposit Figure"; Rec."Maximum Deposit Figure")
                {
                    ApplicationArea = All;
                }
                field("Share Capital Threshold"; Rec."Share Capital Threshold")
                {
                    ApplicationArea = All;
                }
                field("Share Capital Threshold Period"; Rec."Share Capital Threshold Period")
                {
                    ApplicationArea = All;
                }


            }
            group(Member)
            {
                field("Registration Fee"; Rec."Registration Fee")
                {
                    ApplicationArea = All;
                }
                field("Deposit Minimum Contribution"; Rec."Deposit Minimum Contribution")
                {
                    ApplicationArea = All;
                }
                field("Unallocated Payments G/L"; Rec."Unallocated Payments G/L")
                {
                    ApplicationArea = All;
                }
                field("Registration Fee Limit Date"; Rec."Registration Fee Limit Date")
                {
                    ApplicationArea = All;
                }
            }
            group("Bulk SMS")
            {
                field("Bulk SMS Nos"; Rec."Bulk SMS Nos")
                {
                    ApplicationArea = All;
                }
            }
            group(Images)
            {
                field("Image Path Local Directory"; Rec."Image Path Local Directory")
                {
                    ApplicationArea = All;
                }
                field("Image Path IP Address"; Rec."Image Path IP Address")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
    trigger OnOpenPage()
    begin
        //  Message('Huraaah, I have been published');
    end;
}

