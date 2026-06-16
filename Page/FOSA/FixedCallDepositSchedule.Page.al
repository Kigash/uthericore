page 50389 "Fixed/Call Deposit Schedule"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Fixed/Call Deposit Schedule";
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("FD Account No."; Rec."FD Account No.")
                {
                    ApplicationArea = All;

                }
                field("Account Opening No."; Rec."Account Opening No.")
                {
                    ApplicationArea = All;

                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;

                }


                field("Fixed Deposit Amount"; Rec."Fixed Deposit Amount")
                {
                    ApplicationArea = All;

                }

                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = All;

                }

                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;

                }

                field("Fixed Period"; Rec."Fixed Period")
                {
                    ApplicationArea = All;

                }

                field("Maturity Date"; Rec."Maturity Date")
                {
                    ApplicationArea = All;

                }

                field("Capitalization Frequency"; Rec."Capitalization Frequency")
                {
                    ApplicationArea = All;

                }

                field("Source FOSA Account"; Rec."Source FOSA Account")
                {
                    ApplicationArea = All;

                }

                field("Maturity FOSA Account"; Rec."Maturity FOSA Account")
                {
                    ApplicationArea = All;

                }

                field("Next Due Date"; Rec."Next Due Date")
                {
                    ApplicationArea = All;

                }

                field("Interest To Earn"; Rec."Interest To Earn")
                {
                    ApplicationArea = All;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;

                }

                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;

                }

                field("Posted Date"; Rec."Posted Date")
                {
                    ApplicationArea = All;

                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Reporting)
        {
            action(Print)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }

    }




    var
        myInt: Integer;
}