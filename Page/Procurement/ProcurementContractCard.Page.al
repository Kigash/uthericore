page 50782 "Procurement Contract Card"
{
    // version TL2.0

    DeleteAllowed = false;
    Editable = true;
    PageType = Card;
    SourceTable = "Contract Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Process No."; Rec."Process No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Procurement Plan"; Rec."Procurement Plan")
                {
                    ApplicationArea = All;
                }
                field("Procurement Plan Item No."; Rec."Procurement Plan Item No.")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Award Date"; Rec."Award Date")
                {
                    ApplicationArea = All;
                }
                field("Attached Contract"; Rec."Attached Contract")
                {
                    ApplicationArea = All;
                }
                field("Contract Path"; Rec."Contract Path")
                {
                    ApplicationArea = All;
                }
            }
            part(page; "Payment Terms List")
            {
                SubPageLink = "Process No." = FIELD("Process No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Attach Contract")
            {
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    IF ProcurementRequest.GET(Rec."Process No.") THEN BEGIN
                        ProcurementManagement.AttachSubmittedDocument(ProcurementRequest, 6);
                        IF ProcurementRequest2.GET(Rec."Process No.") THEN BEGIN
                            IF ProcurementRequest2."Contract Path" <> '' THEN BEGIN
                                Rec."Attached Contract" := TRUE;
                                Rec."Contract Path" := ProcurementRequest2."Contract Path";
                                Rec.MODIFY;
                            END;
                        END;
                    END;
                end;
            }
            action("View Contract Document")
            {
                Image = Documents;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    IF ProcurementRequest.GET(Rec."Process No.") THEN BEGIN
                        ProcurementManagement.ViewAttachmentDocument(ProcurementRequest, 6);
                    END;
                end;
            }
            action("Capture Payment Terms")
            {
            }
        }
        area(navigation)
        {
            action("View Process Request")
            {
                Image = PostedCreditMemo;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    ProcurementManagement.OpenProcurementRequest(Rec."Process No.");
                end;
            }
            action("View LPO(s) Generated")
            {
                Image = ViewPostedOrder;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    ProcurementManagement.ViewLPOGenerated(Rec);
                end;
            }
        }
    }

    var
        ProcurementRequest: Record "Procurement Request";
        ProcurementManagement: Codeunit "Procurement Management";
        ProcurementRequest2: Record "Procurement Request";
}

