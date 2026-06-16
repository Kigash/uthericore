page 50302 "Loan Defaulter Entries"
{
    // version TL2.0

    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Notification,Attach Guarantor,Reversal,Related Information';
    RefreshOnActivate = true;
    SourceTable = "Loan Defaulter Entry";
    UsageCategory = History;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Loan No."; Rec."Loan No.")
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
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = All;
                }
                field("Repayment Method"; Rec."Repayment Method")
                {
                    ApplicationArea = All;
                }
                field("Repayment Period"; Rec."Repayment Period")
                {
                    ApplicationArea = All;
                }
                field("Loan Start Date"; Rec."Loan Start Date")
                { }
                field("Expected Completion Date"; Rec."Expected Completion Date")
                { }
                field("Phone No"; Rec."Phone No")
                { }
                field("Deposit Balance"; Rec."Deposit Balance" * -1)
                { }
                field("Remaining Period"; Rec."Remaining Period")
                {
                    ApplicationArea = All;
                }
                field("Repayment Frequency"; Rec."Repayment Frequency")
                {
                    ApplicationArea = All;
                }
                field("Remaining Principal Amount"; Rec."Remaining Principal Amount")
                {
                    ApplicationArea = All;
                }
                field("Remaining Interest Amount"; Rec."Remaining Interest Amount")
                {
                    ApplicationArea = All;
                }
                field("Principal Installment"; Rec."Principal Installment")
                {
                    ApplicationArea = All;
                }
                field("Interest Installment"; Rec."Interest Installment")
                {
                    ApplicationArea = All;
                }
                field("Total Installment"; Rec."Total Installment")
                {
                    ApplicationArea = All;
                }
                field("Principal Arrears"; Rec."Principal Arrears")
                {
                    ApplicationArea = All;
                }
                field("Interest Arrears"; Rec."Interest Arrears")
                {
                    ApplicationArea = All;
                }
                field("Ledger Fee Arrears"; Rec."Ledger Fee Arrears")
                {
                    ApplicationArea = All;
                }
                field("Penalty Arrears"; Rec."Penalty Arrears")
                {
                    ApplicationArea = All;
                }
                field("Total Arrears"; Rec."Total Arrears")
                {
                    ApplicationArea = All;
                }
                field("Classification Class"; Rec."Class Description")
                {
                    ApplicationArea = All;
                }
                field("No. of Days in Arrears"; Rec."No. of Days in Arrears")
                {
                    ApplicationArea = All;
                }
                field("Last Payment Date"; Rec."Last Payment Date")
                {
                    ApplicationArea = All;
                }
                field("No. of Defaulted Installment"; Rec."No. of Defaulted Installment")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Balance"; Rec."Outstanding Balance")
                {
                    ApplicationArea = All;
                }

                field("Notice Category"; Rec."Notice Category")
                {
                    ApplicationArea = All;
                }
                field("Notice Date"; Rec."Notice Date")
                {
                    ApplicationArea = All;
                }
                field("Notice Due Date"; Rec."Notice Due Date")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action("Attached Guarantors")
            {
                ApplicationArea = All;
                Image = LinkAccount;
                Promoted = true;
                PromotedCategory = Category7;
                PromotedIsBig = true;
                RunObject = page "Attached Guarantor Entries";
                RunPageLink = "Loan No." = field("Loan No.");

            }

        }
        area(Processing)
        {
            action("Send Defaulter Notice")
            {
                ApplicationArea = All;
                Image = SendToMultiple;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Send notices to defaulters';
                trigger OnAction()
                begin
                    if Confirm(SendDefaulterNoticeConfirmMsg, true, Rec."Loan No.", Rec.Description) then begin
                        BOSAManagement.SendDefaulterNotice(Rec);
                    end;
                end;

            }
            action("Attach Loan")
            {
                ApplicationArea = All;
                Image = SendToMultiple;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ToolTip = 'Attach Guarantors';
                trigger OnAction()
                begin
                    if Confirm(AttachLoanGuarantorsConfirmMsg, true, Rec."Loan No.", Rec.Description) then begin
                        //BOSAManagement.AttachLoanToGuarantor(Rec);
                    end;
                end;
            }
            action("Reverse Attached Loan")
            {
                ApplicationArea = All;
                Image = SendToMultiple;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                ToolTip = 'Reverse Attached Loan';
                trigger OnAction()
                begin

                    if Confirm(ReverseAttachedLoanConfirmMsg, true, Rec."Loan No.", Rec.Description) then begin
                        BOSAManagement.ReverseAttachedLoan(Rec);
                    end;
                end;
            }
        }
    }


    var
        SendDefaulterNoticeConfirmMsg: Label 'Do you want to send defaulter notice for loan %1 %2?';
        AttachLoanGuarantorsConfirmMsg: Label 'Do you want to attach guarantors to loan %1 %2?';
        ReverseAttachedLoanConfirmMsg: Label 'Do you want to reverse attached guarantors for loan %1 %2?';
        BOSAManagement: Codeunit "BOSA Management";
        DepositsBal: Decimal;
}

