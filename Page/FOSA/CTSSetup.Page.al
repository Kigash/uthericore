page 50157 "CTS Setup"
{
    // version CTS2.0

    PageType = Card;
    SourceTable = "CTS Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Cheque Book Nos."; Rec."Cheque Book Nos.")
                {
                    ApplicationArea = All;
                }
                field("Cheque Book Application Nos."; Rec."Cheque Book Application Nos.")
                {
                    ApplicationArea = All;
                }
                field("Cheque Clearance Nos."; Rec."Cheque Clearance Nos.")
                {
                    ApplicationArea = All;
                }

                field("Charges Per Leaf"; Rec."Charges Per Leaf")
                {
                    ApplicationArea = All;
                }
                field("Charges G/L Account"; Rec."Charges G/L Account")
                {
                    ApplicationArea = All;
                }

                field("Cheque Clearance Account"; Rec."Cheque Clearance Account")
                {
                    ApplicationArea = All;
                }
                field("Clearance Charges"; Rec."Clearance Charges")
                {
                    ApplicationArea = All;
                }

                field("Commission G/L Account"; Rec."Commission G/L Account")
                {
                    ApplicationArea = All;
                }

                field("SMS Charges"; Rec."SMS Charges")
                {
                    ApplicationArea = All;
                }
                field("SMS G/L Account"; Rec."SMS G/L Account")
                {
                    ApplicationArea = All;
                }
                field("Penalty G/L Account"; Rec."Penalty G/L Account")
                {
                    ApplicationArea = All;
                }
                field("Charge Excise Duty"; Rec."Charge Excise Duty")
                {
                    ApplicationArea = All;
                }
            }
            group(Posting)
            {
                field("Cheque Template Name"; Rec."Cheque Template Name")
                {
                    ApplicationArea = All;
                }
                field("Cheque Batch Name"; Rec."Cheque Batch Name")
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

