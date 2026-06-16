page 50703 "Procurement Setup"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Procurement Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Procurement Manager"; Rec."Procurement Manager")
                {
                    ApplicationArea = All;
                }
                field("Procurement Plan Deadline"; Rec."Procurement Plan Deadline")
                {
                    ApplicationArea = All;
                }
                field("Procurement Email"; Rec."Procurement Email")
                {
                    ExtendedDatatype = EMail;
                    ApplicationArea = All;
                }
                field("CEO's Account"; Rec."CEO's Account")
                {
                    ApplicationArea = All;
                }
                field("Purchase Requisition Source"; Rec."Purchase Requisition Source")
                {
                    ApplicationArea = All;
                }
                field("Procurement Documents Path"; Rec."Procurement Documents Path")
                {
                    ApplicationArea = All;
                }
                field("Purchase Req. From Plan"; Rec."Purchase Req. From Plan")
                {
                    ToolTip = 'Should the Purchase Requisition be read from the Procurement Plan?';
                    ApplicationArea = All;
                }
            }
            group(Numbering)
            {
                Caption = 'Numbering';
                field("Procurement Plan No."; Rec."Procurement Plan No.")
                {
                    ApplicationArea = All;
                }
                field("Purchase Requisition No."; Rec."Purchase Requisition No.")
                {
                    ApplicationArea = All;
                }
                field("Store Requisition No."; Rec."Store Requisition No.")
                {
                    ApplicationArea = All;
                }
                field("Store Return No."; Rec."Store Return No.")
                {
                    ApplicationArea = All;
                }
                field("Direct Procurement No."; Rec."Direct Procurement No.")
                {
                    ApplicationArea = All;
                }
                field("Low Value No."; Rec."Low Value No.")
                {
                    ApplicationArea = All;
                }
                field("Request For Quotation No."; Rec."Request For Quotation No.")
                {
                    ApplicationArea = All;
                }
                field("Request For Proposal No."; Rec."Request For Proposal No.")
                {
                    ApplicationArea = All;
                }
                field("Open Tender No."; Rec."Open Tender No.")
                {
                    ApplicationArea = All;
                }
                field("Restricted Tender No."; Rec."Restricted Tender No.")
                {
                    ApplicationArea = All;
                }
                field("Purchase Order No."; Rec."Purchase Order No.")
                {
                    ApplicationArea = All;
                }
                field("Evaluation Requirement No."; Rec."Evaluation Requirement No.")
                {
                    ApplicationArea = All;
                }
                field("Contract No."; Rec."Contract No.")
                {
                    ApplicationArea = All;
                }
            }
            group("Posting Setup")
            {
                Caption = 'Posting Setup';
                field("Item Journal Template"; Rec."Item Journal Template")
                {
                    ApplicationArea = All;
                }
                field("Item Journal Batch"; Rec."Item Journal Batch")
                {
                    ApplicationArea = All;
                }
                field("Tender Fee G/L"; Rec."Tender Fee G/L")
                {
                    ApplicationArea = All;
                }
            }
            group("Procurement Methods Setup")
            {
                Caption = 'Procurement Methods Setup';
                field("Max. RFQ Limit"; Rec."Max. RFQ Limit")
                {
                    ApplicationArea = All;
                }
                field("Max. Low Value Limit"; Rec."Max. Low Value Limit")
                {
                    ApplicationArea = All;
                }
                field("Tender Security Option"; Rec."Tender Security Option")
                {
                    ApplicationArea = All;
                }
                field("Fixed Tender Security Amount"; Rec."Fixed Tender Security Amount")
                {
                    ApplicationArea = All;
                }
                field("Tender Security Percentage"; Rec."Tender Security Percentage")
                {
                    ApplicationArea = All;
                }
                field("RFQ Request Option"; Rec."RFQ Request Option")
                {
                    ApplicationArea = All;

                }
            }
            group("Evaluation Process")
            {
                field("Evaluation Based On"; Rec."Evaluation Based On")
                {
                    ApplicationArea = All;
                }
                field("Mandatory Pass Limit(%)"; Rec."Mandatory Pass Limit(%)")
                {
                    ApplicationArea = All;
                }
                field("Technical Pass Limit(%)"; Rec."Technical Pass Limit(%)")
                {
                    ApplicationArea = All;
                }
                field("Financial Pass Limit(%)"; Rec."Financial Pass Limit(%)")
                {
                    ApplicationArea = All;
                }
                field("Overall Pass Limit(%)"; Rec."Overall Pass Limit(%)")
                {
                    ApplicationArea = All;

                }
                field(FailedSupplierTxt; FailedSupplierTxt)
                {
                    Caption = 'Failed Supplier Regret Message';
                    MultiLine = true;
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        Rec."Failed Supplier Regret Msg".CREATEOUTSTREAM(FailedSupplierOutstr);
                        FailedSupplierOutstr.WRITE(FailedSupplierTxt);
                    end;
                }
                field(EvaluationSuccessTxt; EvaluationSuccessTxt)
                {
                    ApplicationArea = All;
                    Caption = 'Evaluation Success Message';
                    MultiLine = true;

                    trigger OnValidate();
                    begin
                        Rec."Evaluation Success Msg".CREATEOUTSTREAM(EvaluationSuccessOutstr);
                        EvaluationSuccessOutstr.WRITE(EvaluationSuccessTxt);
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        ManageVisibility
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        ManageVisibility
    end;

    trigger OnOpenPage();
    begin
        ManageVisibility;
    end;

    var
        FailedSupplierTxt: Text;
        FailedSupplierOutstr: OutStream;
        FailedSupplierInstr: InStream;
        EvaluationSuccessTxt: Text;
        EvaluationSuccessOutstr: OutStream;
        EvaluationSuccessInstr: InStream;

    local procedure ManageVisibility();
    begin
        Rec.CALCFIELDS("Failed Supplier Regret Msg");
        Rec."Failed Supplier Regret Msg".CREATEINSTREAM(FailedSupplierInstr);
        FailedSupplierInstr.READ(FailedSupplierTxt);

        Rec.CALCFIELDS("Evaluation Success Msg");
        Rec."Evaluation Success Msg".CREATEINSTREAM(EvaluationSuccessInstr);
        EvaluationSuccessInstr.READ(EvaluationSuccessTxt);
    end;
}
