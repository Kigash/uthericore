page 50290 "Payout Setup"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Payout Setup";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                // Caption = 'Charges';


                field("Payout Nos."; Rec."Payout Nos.")
                {
                    ApplicationArea = All;
                }
                field("Charges Calculation Method"; Rec."Charges Calculation Method")
                {
                    ApplicationArea = All;
                }
                group(Flat)
                {
                    Caption = '';
                    Visible = Rec."Charges Calculation Method" = 1;
                    field("Flat Amount"; Rec."Flat Amount")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Percentage)
                {
                    Caption = '';
                    Visible = Rec."Charges Calculation Method" = 0;
                    field("Charge %"; Rec."Charge %")
                    {
                        ApplicationArea = All;
                    }
                }
                field("Charges G/L Account"; Rec."Charges G/L Account")
                {
                    ApplicationArea = All;
                }
                field("FOSA Account Type"; Rec."FOSA Account Type")
                {
                    ApplicationArea = All;
                }
                field("Charge Witholding Tax"; Rec."Charge Witholding Tax")
                {
                    ApplicationArea = All;
                }
                field("Charge Excise Duty"; Rec."Charge Excise Duty")
                {
                    ApplicationArea = All;
                }
            }
            group(Notification)
            {
                Caption = 'Notification';
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
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field("Email Template"; Rec."Email Template")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
            }
            group(Posting)
            {
                field("Payout Template Name"; Rec."Payout Template Name")
                {
                    ApplicationArea = All;
                }
                field("Payout Batch Name"; Rec."Payout Batch Name")
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

