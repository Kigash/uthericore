page 50392 "Fixed/Call Deposit Summary"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Fixed/Call Deposit Summary";
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
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;

                }

                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;

                }

                field("Member Name"; Rec."Member Name")
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

                field("Total Interest To Earn"; Rec."Total Interest To Earn")
                {
                    ApplicationArea = All;

                }

                field("Total Amount To Earn"; Rec."Total Amount To Earn")
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
        area(Navigation)
        {
            action("Fixed Deposit Schedule")
            {
                ApplicationArea = All;
                Image = Relationship;
                RunObject = page "Fixed/Call Deposit Schedule";
                RunPageLink = "FD Account No." = field("FD Account No.");
            }
        }
        area(Processing)
        {
            action("Mature Fixed/Call Deposit")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Image = ContactPerson;
                trigger OnAction()
                begin
                    if Confirm(MatureFDCallDepositConfirmMsg, true, Rec."FD Account No.") then
                        FOSAManagement.MatureFixedCallDeposit(Rec);
                end;
            }
            action("Revoke Fixed/Call Deposit")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Image = ContactPerson;
                trigger OnAction()
                begin
                    if Confirm(RevokeFDCallDepositConfirmMsg, true, Rec."FD Account No.") then
                        FOSAManagement.RevokeFixedCallDeposit(Rec);
                end;
            }
        }
        area(Reporting)
        {
            action("Print")
            {
                ApplicationArea = All;
                Image = Relationship;
                RunObject = report "Fixed/Call Deposit Summary";
            }

        }



    }

    local procedure CalculateTotalAmountToEarn()
    var

    begin
        Rec.CalcFields("Total Interest To Earn");
        Rec."Total Amount To Earn" := Rec."Fixed Deposit Amount" + Rec."Total Interest To Earn";
    end;

    trigger OnAfterGetRecord()
    var

    begin
        CalculateTotalAmountToEarn();
    end;

    var
        Vendor: Record Vendor;
        MatureFDCallDepositConfirmMsg: Label 'Do you want to Mature Fixed/Call Deposit %1?';
        RevokeFDCallDepositConfirmMsg: Label 'Do you want to Revoke Fixed/Call Deposit %1?';
        FOSAManagement: Codeunit "FOSA Management";
}